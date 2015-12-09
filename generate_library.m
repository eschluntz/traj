
% like the double integrator, but on a 2D plain.
%{
Plan:
1. x0 = (0,0) and xf = (f,0)
2. for every f, construct a bunch of trajectories with obstacles and save
them
3. sort trajs by time, so we can take the first that works

Runtime:
1. transform coords so x0 = (0,0), xf = (f,0)
2. grab all the trajs for f
3. select traj with lowest cost that doesn't collide (keep in sorted
order)
4. perform a few steps of opt. on this to adjust.
5. transform coords back to world frame

TODO:
<X> reasonable init condits
<X> coordinate transformation from x0, xf
<X> construct and save trajectories
<X> sort by time
< > load trajs based on xf
<X> check validity of traj with current obstacles
< > perform a bit of opt.
< > return commands!
%}
  
% Simple example of Direct Transcription trajectory optimization
% X = [x, y, vx, vy]';
clear;
close all;

% LIBRARY STRUCTURE
debug = true;

d = 1:.5:5;
n_runs = 15;
runs = 1:n_runs;
settings = combvec(d,runs);
N = size(settings,2);
lib_d = zeros(N,1);
lib_tf = zeros(N,1);
lib_x = [];
lib_u = [];
lib_x{N} = [];
lib_u{N} = [];

for n = 1:N;
    row = settings(:,n);
    d = row(1);
    j = row(2);
    
    % inputs
    x0 = [0;0;0;0];
    xf = [d;d;0;0];
    
    if j == 1
        obstacles = [];
        r = [];
    else
        [obstacles, r] = gen_obstacles(x0,xf);
    end

    % solve
    [xtraj, utraj, tf] = gen_traj(x0,xf, obstacles, r, debug);

    % save
    lib_d(n) = d;
    lib_tf(n) = tf;
    lib_x{n} = xtraj;
    lib_u{n} = utraj;
end

save 'library.mat' lib_d lib_tf lib_x lib_u;


