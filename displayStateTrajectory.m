function displayStateTrajectory(t,x,u, obstacles, rs)
    plot(x(1,:),x(2,:),'b.-','MarkerSize',10);
    viscircles(obstacles, rs);
    axis([-1,6,-3,3]); axis equal;
    drawnow;
end