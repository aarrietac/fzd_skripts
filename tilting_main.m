% Main simulation and animation for tilting
close all
clc

% Add utilities folder to the path
addpath('utilities/');

% Passenger car - geometric parameters
g  = 9.81;
m  = 1500;
a1 = 1.5;
a2 = 2.595 - a1;
h  = 0.8;

% Create figure for animation
hfm_gui = figure;
set(hfm_gui,'NumberTitle','off')
set(hfm_gui,'MenuBar','none');
set(hfm_gui,'Toolbar','none');
set(hfm_gui,'Name','Tilting limits')
set(hfm_gui,'Units','normalized')
set(hfm_gui,'Position', [0.1 0.1 0.75 0.75]);

% Create road line
roadx = [-1, 5]; roady = [0, 0];

% Create bodies for animation
car = carBody();
[xwhlF, ywhlF] = uty_createcircle([0.85 car.tire.r0], car.tire.r0);
[xwhlR, ywhlR] = uty_createcircle([0.85+car.shape.wb car.tire.r0], car.tire.r0);

plot([-1 5], [0 0], '--k'), hold on
scatter(0, 0, 80)
hroad = line(roadx, roady, 'Color', 'k');
hcar  = patch(car.shape.x, car.shape.y, 'k', 'FaceColor', 'none');
hwhlF = patch(xwhlF, ywhlF, 'k', 'FaceColor', 'none');
hwhlR = patch(xwhlR, ywhlR, 'k', 'FaceColor', 'none');

% Display normal forces
hFz1 = text(4.0, 0.6, ['Fz1 = ',  num2str(0.0), ' N']);
set(hFz1, 'FontSize', 12, 'FontWeight', 'bold');
set(hFz1, 'HorizontalAlignment', 'center');

hFz2 = text(4.0, 2.5, ['Fz2 = ',  num2str(0.0), ' N']);
set(hFz2, 'FontSize', 12, 'FontWeight', 'bold');
set(hFz2, 'HorizontalAlignment', 'center');

% Car parameters
t = text(-2.0, 3.0, ['Mass = ', num2str(m, '%.1f'), ' kg']);
t.FontSize = 12; t.FontWeight = 'bold';
t = text(-2.0, 2.7, ['a1 = ', num2str(a1, '%.1f'), ' m']);
t.FontSize = 12; t.FontWeight = 'bold';
t = text(-2.0, 2.4, ['a2 = ', num2str(a2, '%.1f'), ' m']);
t.FontSize = 12; t.FontWeight = 'bold';
t = text(-2.0, 2.1, ['h = ', num2str(h, '%.1f'), ' m']);
t.FontSize = 12; t.FontWeight = 'bold';

% Display road inclination angle
halp = text(0.8, 0.15, ['alp = ',  num2str(0.0), ' deg']);
set(halp, 'FontSize', 12, 'FontWeight', 'bold');
set(halp, 'HorizontalAlignment', 'center');

% Control animation
istop = 0;
imovie = 0;

axis('manual')
axis 'equal'
axis 'off'

% Animation loop
alp = 0:0.005:70*pi/180;
n = length(alp);

for i=1:n

    % Define and calculate transformation matrix
    alpi = alp(i);
    R = [cos(alpi), -sin(alpi);
         sin(alpi),  cos(alpi)];
    
    pRoad = uty_rotate2D(R, [roadx', roady']);
    pCar  = uty_rotate2D(R, [car.shape.x, car.shape.y]);
    pWhlF = uty_rotate2D(R, [xwhlF', ywhlF']);
    pWhlR = uty_rotate2D(R, [xwhlR', ywhlR']);
    
    % Update bodies
    set(hroad, 'XData', pRoad(:, 1), 'YData', pRoad(:,2));
    set(hcar , 'XData',   pCar(:,1), 'YData',  pCar(:,2));
    set(hwhlF, 'XData',  pWhlF(:,1), 'YData', pWhlF(:,2));
    set(hwhlR, 'XData',  pWhlR(:,1), 'YData', pWhlR(:,2));
    
    % Update text in figure
    set(halp, 'String', ['ang = ', num2str(alpi*180/pi, '%.1f'), ' deg']);
    
    % Compute normal forces according to road inclination
    Fz1 = m*g*cos(alpi)*(a2 + h*tan(alpi))/(a1 + a2);
    Fz2 = m*g*cos(alpi)*(a1 - h*tan(alpi))/(a1 + a2);
    
    set(hFz1, 'String', ['Fz1 = ', num2str(Fz1, '%.1f'), ' N']);
    set(hFz2, 'String', ['Fz2 = ', num2str(Fz2, '%.1f'), ' N']);
    
    drawnow;
    
    % Fix axis limits
    xlim([-1 5]), ylim([-1 4.2])
    
    if Fz2 < 0
        hTilt = text(4.0, 3.5, 'Tilt limit!', 'Color', 'r');
        set(hTilt, 'FontSize', 14, 'FontWeight', 'bold');
        set(hTilt, 'HorizontalAlignment', 'center');
        istop = 1;
    end
    
    F(i) = getframe(gcf);
    
    if istop == 1
       break;
    end
end

if imovie == 1
    % create the video writer with 1 fps
    writerObj = VideoWriter('Tilting_limits.avi');
    writerObj.FrameRate = 15;

    % set the seconds per image
    % open the video writer
    open(writerObj);

    % write the frames to the video
    for i=1:length(F)
        % convert the image to a frame
        frame = F(i);    
        writeVideo(writerObj, frame);
    end
    % close the writer object
    close(writerObj);
end