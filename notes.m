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
<X> better collection of obstacles to use
    > none, 
    > center (small, med, large, full) * (up, down)
    > (left, right) * (small, med)
    > snake * (up, down)
    This is 15 total, should be decent
<X> build library for velocity init condits
< > secondary optimization
< > metrics for testing
< > presentation

Presentation outline:
> motivation: what is robocup?
> motivation: why is this interesting / underactuated?
> overview of solution: trajectory libraries
> system
> training
    805 trajectories in library
    generated in 7 minutes (428.4 seconds)
> selecting
> results
> next steps (discretization error, final optimization, local solutions?)
%}