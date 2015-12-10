%{
Notes for Trajectory Library project

Goals:
< > realtime path planning including dynamics and obstacles
< > compute time < 50ms
< > paths within 80% of optimal

Flow:
1. [offline] Generate library of trajectories for every...
        a. distance to target
        b. initial velocity
    This assumes final velocity is zero.
    We can map away orientation and most position
2. [offline] Sort library by fastest options
3. [Online] check down library for first trajectory that does not collide
4. [Online] perform few steps of optimization

TODO:
<X> add circular force constraint
< > better collection of obstacles to use
    > none, 
    > center (small, med, large, full) * (up, down)
    > (left, right) * (small, med)
    > snake * (up, down)
    This is 15 total, should be decent
< > build library for velocity init condits
< > metrics for testing
< > presentation
%}