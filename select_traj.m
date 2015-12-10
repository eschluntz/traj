% selects a trajectory from the library
% inputs: all library vars. d, obstacles, rs

% inputs

v0 = [1; 1];

infeasibles = 0;
scores = [];
for j = 1:1
    d = 5;%1+ ceil(4*rand());
    %[obstacles, rs] = gen_rand_obstacles([0;0],[d;0]);
    clf;
    hold on;
    %clf;
    tic
    % assume library is already sorted by tf
    indices = select_indices(d, v0, opts_x0, lib_d, lib_x0);
    traj_xs = lib_x(indices);
    traj_us = lib_u(indices);
    traj_tf = lib_tf(indices);
    n = size(traj_xs,2);

    best_x = [];
    best_u = [];
    select_tf = -1;

    %hold on;
    for i = 1:n
        if check_traj(traj_xs{i}, obstacles, rs)
            % works!
            best_x = traj_xs{i};
            best_u = traj_us{i};
            select_tf = traj_tf(i);
            draw_traj(best_x, obstacles,rs, 'b-');
            %break;
        else
            draw_traj(traj_xs{i}, obstacles, rs, 'r.-');
        end
    end
    select_time = toc;
    %{
    tic
    % now compare to optimal
    [xtraj, utraj, opt_tf] = gen_traj([0;0;0;0],[d;0;0;0], obstacles, rs, false);
    opt_time = toc;

    % display
    
    %axis([-1,6,-3,3]);
    
    if select_tf ~= -1
        scores = [scores; select_time, opt_time, select_tf, opt_tf];
    else
        infeasibles = infeasibles + 1;
    end
    j
    %}
end