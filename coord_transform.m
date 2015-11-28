function [M, iM] = coord_transform(x0,xf)
% M * [x,y,1]' = x' y'
    xf = xf - x0;
    th = -atan2(xf(2),xf(1));

    R = [cos(th), -sin(th);
        sin(th), cos(th)];
    iR = [cos(-th), -sin(-th);
        sin(-th), cos(-th)];
    M = [R, R*-x0];
    iM = [iR, x0];
end

