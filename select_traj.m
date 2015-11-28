% selects a trajectory from the library
% inputs: all library vars. d, obstacles, rs

% assume library is already sorted by tf

indices = (lib_d == d);
traj_xs = lib_x(indices);
traj_us = lib_u(indices);
n = size(lib_x,2);

best_x = [];
best_u = [];

figure;
hold on;
for i = 1:n
    if check_traj(traj_xs{i}, obstacles, rs)
        % works!
        best_x = traj_xs{i};
        best_u = traj_us{i};
        draw_traj(best_x, obstacles,rs);
        break;
    else
        draw_traj(traj_xs{i}, obstacles, rs, 'r.-');
    end
end