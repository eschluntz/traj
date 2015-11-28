function draw_traj(xtraj,obs,rs, opt)
    if nargin < 4
        opt = 'b.-';
    end
    x = xtraj.eval(0:.1:xtraj.tspan(2));
    plot(x(1,:),x(2,:),opt,'MarkerSize',10);
    axis equal;
    viscircles(obs, rs);
    drawnow;
end