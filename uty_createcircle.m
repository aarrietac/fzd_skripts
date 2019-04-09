function [xc, yc] = create_circle(pc, radius)

    t = 0:0.01:2*pi;
    xc = pc(1) + radius.*sin(t);
    yc = pc(2) + radius.*cos(t);

end