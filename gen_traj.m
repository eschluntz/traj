function [xtraj, utraj, tf] = gen_traj(x0,xf, obstacles, rs, debug)
%gen_traj Generate a trajectory for a given setup.
    
% system
    rho = .4;
    ulim = 1;
    A = [0,0,1,0;
        0,0,0,1;
        0,0,-rho,0;
        0,0,0,-rho];
    B = [0,0;
        0,0;
        1,0;
        0,1];
    C = eye(4);
    D = [];

    plant = LinearSystem(A,B,[],[],C,D);
    plant = setInputLimits(plant,-ulim,ulim); % bounding square, need to do sphere
    plant = setOutputFrame(plant,getStateFrame(plant));

    % set up a direct transcription problem with N knot points and bounds on
    % the duration
    N = 30;
    prog = DircolTrajectoryOptimization(plant,N,[0.1 10]);
    prog = addStateConstraint(prog,ConstantConstraint(x0),1);
    prog = addStateConstraint(prog,ConstantConstraint(xf),N);
    prog = addInputConstraint(prog,QuadraticConstraint(0, 1, 2*eye(2), zeros(2, 1)), 1:N);

    
    % add obstacles
    Q = 2*diag([1,1,0,0]); % only count x and y
    for i = 1:size(obstacles,1)
        ob = [obstacles(i,:) 0 0]';
        B = -2*ob;
        lb = rs(i)^2 - ob'*ob;
        ub = 10000;
        obst = QuadraticConstraint(lb,ub,Q,B);
        prog = addStateConstraint(prog,obst, 1:N);
    end

    prog = addRunningCost(prog,@cost);

    % add a display function to draw the trajectory on every iteration
    function wrapped_draw(x,t,u)
        displayStateTrajectory(x,t,u,obstacles,rs);
    end
    if debug
        prog = addTrajectoryDisplayFunction(prog,@wrapped_draw);
    end
    
    [x,u, tf] = guess_init_traj(x0,xf, rho, ulim, N); % returns PPTrajectories

    guess = struct('u',u,'x',x);
    [xtraj,utraj,~,tf,~,~] = prog.solveTraj(tf, guess);
    % viscircles(obstacles, repmat(r,nob,1));
end