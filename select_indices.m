function [indices] = select_indices(d, v0, opts_x0, lib_d, lib_x0)
%select_indices Summary of this function goes here
    
% select closest initial velocity
[~, x0i] = min(sum((opts_x0 - repmat(v0,1,size(opts_x0,2))).^2));

tol = .01;

vi =opts_x0(:,x0i);
indices = (lib_d == d) & (lib_x0(:,1) == vi(1)) & (lib_x0(:,2) == vi(2));
end

