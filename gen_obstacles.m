function [ obs, rs ] = gen_obstacles(x0, xf)
%gen_obstacles Summary of this function goes here
    x0 = x0(1:2);
    xf = xf(1:2);
    d = abs(x0(1) - xf(1));
    r_max = d/1.5;
    r_min = d/4;
    obn = 1;
    
    obbox = repmat([d, d],obn,1); % box
    oboff = repmat([0, 0], obn,1); % offset
    
    obs = obbox .* rand(obn,2) + oboff;
    rs = (r_max-r_min) * rand(obn,1) + r_min;
    
    % check if they contain x0 or xf
    dx0 = sqrt(sum((obs - repmat(x0',obn,1)).^2,2));
    dxf = sqrt(sum((obs - repmat(xf',obn,1)).^2,2));
    rs = min([rs,dx0,dxf]')';
end

