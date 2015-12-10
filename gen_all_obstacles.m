function [ obss, rss ] = gen_all_obstacles(x0, xf)
    %gen_all_obstacles Generates a set of all obstacles to try. output is 3D
    %{ 
    <X> none, 
    <X> center (small, med, large, full) * (up, down)
    <X> (left, right) * (small, med)
    < > snake * (up, down)
    %}
    x0 = x0(1:2);
    xf = xf(1:2);

    % defines
    dist = norm(xf - x0);
    center = mean([xf,x0],2)';

    rads = [dist/10, dist/5, dist/3, dist/2] - .1; % radiuses


    % outer layer is cell, because inner layers are different sizes
    obss = {{}};
    rss = {{}};
    i = 1;

    % 1. none
    obss{i} = [];
    rss{i} = [];
    i = i + 1;
    
    % center pushes
    for rad = rads
        for offset = [rad/2, -rad/2]
            obss{i} = [center; center + [0, offset]];
            rss{i} = [rad;rad];
            i = i + 1;
        end
    end
    
    % left / right
    for offset_x = [-dist/4, dist/4]
        for rad = [dist/8, dist/5] - .1
            for offset_y = [rad/2, -rad/2]
                obss{i} = [center + [offset_x, 0]; center + [offset_x, offset_y]];
                rss{i} = [rad;rad];
                i = i + 1;
            end
        end
    end
    
    % snake
    rad = dist /5;
    for offset = [rad/1.5, rad/2, rad/4, -rad/4, -rad/2, -rad/1.5];
        obss{i} = [center + [dist/4,offset]; center - [dist/4,offset]];
        rss{i} = [dist/5; dist/5];
        i = i + 1;
    end
    
    % draw obstacles
    %{
    for j = 1:(i-1)
        clf;
        axis equal;
        axis([-1,5,-3,3]);
        viscircles(obss{j}, rss{j});
        pause(.1);
    end
    %}

end

