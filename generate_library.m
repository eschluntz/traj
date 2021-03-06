
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
tic

% LIBRARY STRUCTURE
debug = true;

% creating library space
d = 5;

ths = linspace(0,5/3*pi,6);
vis = 1.5 * [cos(ths); sin(ths)];
vis = [0;0];% [vis,[0;0]];

n_runs = 23;
runs = 1:n_runs;

settings = combvec(runs,d,vis); % distance, obstacle set, init velocity
N = size(settings,2);
lib_d = zeros(N,1); % init distance
lib_x0 = zeros(N,2); % init velocity
lib_tf = zeros(N,1);
lib_x = [];
lib_u = [];
lib_x{N} = [];
lib_u{N} = [];

for n = 1:N;
    row = settings(:,n);
    disp(row);
    d = row(2);
    j = row(1);
    
    % inputs
    x0 = [0;0;row(3);row(4)]; % initial velocity
    xf = [d;0;0;0];
    
    [obss, rss] = gen_all_obstacles(x0, xf);
    
    obstacles = obss{j};
    r = rss{j};

    % solve
    [xtraj, utraj, tf] = gen_traj(x0,xf, obstacles, r, debug);

    % save
    lib_d(n) = d;
    lib_x0(n,:) = x0(3:4)';
    lib_tf(n) = tf;
    lib_x{n} = xtraj;
    lib_u{n} = utraj;
end

opts_x0 = vis;
toc
save 'library_demo.mat' lib_d lib_x0 opts_x0 lib_tf lib_x lib_u;


