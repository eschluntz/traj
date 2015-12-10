% sort first by d, then by time for fast lookups
% input d, obstacles, rs

load 'library_full.mat';

% grab
[values, order] = sort(lib_tf);

% put
lib_d = lib_d(order);
lib_x0 = lib_x0(order,:);
lib_tf = lib_tf(order);
lib_x = lib_x(order);
lib_u = lib_u(order);

save 'library_sorted.mat' lib_d lib_x0 lib_tf lib_x lib_u;