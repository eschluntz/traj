function [xtraj, utraj, tf] = guess_init_traj(x0,xf,rho,ulim,N)
%guess_init_traj guesses initial trajectory based on coords, and terminal
    % velocity
    delta = xf(1:2) - x0(1:2);
    dist = sqrt(delta' * delta);
    vterm = ulim / rho; % terminal velocity
    tf = dist / vterm;

    % components
    xfrac = delta(1) / dist;
    yfrac = delta(2) / dist;
    v = vterm * [xfrac, yfrac];
    u = ulim * [xfrac, yfrac];
    
    % turn into PPTrajectories
    utraj = PPTrajectory(ppmak([0,tf],u')); % first order
    xtraj = PPTrajectory(ppmak([0,tf],[v(1),0; v(2),0; 0,v(1); 0,v(2)])); % 2nd order
end