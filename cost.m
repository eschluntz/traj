function [g,dg] = cost(dt,x,u)
% add the cost function g(dt,x,u) = 1*dt
    g = dt; dg = [1,0*x',0*u']; % see geval.m for our gradient format
end