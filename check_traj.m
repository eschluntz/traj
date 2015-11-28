function [ valid ] = check_traj(traj, obs, rs)
%check_traj See if a trajectory has any collisions
    tf = traj.tspan(2);
    ts = linspace(0,tf,30);
    xs = traj.eval(ts);
    xs = xs(1:2,:)'; % rows now
    
    n = size(xs,1);
    
    valid = true;
    % check against each obstacle
    for i = 1:size(obs,1)
        ob = repmat(obs(i,:),n,1);
        
        dists = sum((xs - ob).^2,2);
        collisions = sum(dists < rs(i)^2);
        if collisions > 0
            valid = false;
            break;
        end
    end
end

