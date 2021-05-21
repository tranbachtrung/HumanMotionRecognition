function [] = quatVisMulti(quat)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[q0,q1,q2,q3] = parts(quat);
x = rotatepoint(quat,[1 0 0]);
y = rotatepoint(quat,[0 1 0]);
z = rotatepoint(quat,[0 0 1]);

fighand = findobj('Type','figure','Name','mainfigure');
if ~isempty(fighand)
    % get the handles if the figure already exist
    fighand = figure(fighand);
    orientation_plot = fighand.Children(5);
    q0_plot = fighand.Children(4);
    q1_plot = fighand.Children(3);
    q2_plot = fighand.Children(2);
    q3_plot = fighand.Children(1);
    
else
    % create figure and subplots if the figure does not exist
    fighand = figure('Name','mainfigure');
    titletext = {'Quaternion Visualization'};
    sgtitlesetup(titletext)
    set(gcf, 'Position', get(0, 'Screensize'));
    
    orientation_plot = subplot(2,4,[1 2 5 6]);
    [sx,sy,sz] = sphere;
    mesh(sx,sy,sz,'edgecolor','k','FaceAlpha',0,'EdgeAlpha',0.1)
    titletext = '3D Quaternion Representation';
    xlabeltext = '$x$';
    ylabeltext = '$y$';
    zlabeltext = '$z$';
    titlesetup(titletext)
    axessetup(xlabeltext,ylabeltext,zlabeltext)
    
    q0_plot = subplot(2,4,3);
    ylim([-1 1])
    titletext = 'Magnitude Component';
    xlabeltext = 'index';
    ylabeltext = 'value';
    titlesetup(titletext)
    axessetup(xlabeltext,ylabeltext)
    
    q1_plot = subplot(2,4,4);
    ylim([-1 1])
    titletext = 'i-Component ';
    xlabeltext = 'index';
    ylabeltext = 'value';
    titlesetup(titletext)
    axessetup(xlabeltext,ylabeltext)

    q2_plot = subplot(2,4,7);
    ylim([-1 1])
    titletext = 'j-Component';
    xlabeltext = 'index';
    ylabeltext = 'value';
    titlesetup(titletext)
    axessetup(xlabeltext,ylabeltext) 

    q3_plot = subplot(2,4,8);
    ylim([-1 1])
    titletext = 'k-Component';
    xlabeltext = 'index';
    ylabeltext = 'value';
    titlesetup(titletext)
    axessetup(xlabeltext,ylabeltext) 
    
end

hold(orientation_plot,'on');
array = [x(:,1) x(:,2) x(:,3); y(:,1),y(:,2),y(:,3); z(:,1),z(:,2),z(:,3)];
plot3(orientation_plot,array(:,1),array(:,2),array(:,3),'.','MarkerSize',10,'Linewidth',2)

% plot3(orientation_plot,x(1,1),x(1,2),x(1,3),'p','MarkerSize',15,'Linewidth',2)
% plot3(orientation_plot,y(1,1),y(1,2),y(1,3),'p','MarkerSize',15,'Linewidth',2)
% plot3(orientation_plot,z(1,1),z(1,2),z(1,3),'p','MarkerSize',15,'Linewidth',2)
% plot3(orientation_plot,x(:,1),x(:,2),x(:,3),'MarkerSize',10,'Linewidth',2)
% plot3(orientation_plot,y(:,1),y(:,2),y(:,3),'MarkerSize',10,'Linewidth',2)
% plot3(orientation_plot,z(:,1),z(:,2),z(:,3),'MarkerSize',10,'Linewidth',2)
% plot3(orientation_plot,x(end,1),x(end,2),x(end,3),'sq','MarkerSize',15,'Linewidth',2)
% plot3(orientation_plot,y(end,1),y(end,2),y(end,3),'sq','MarkerSize',15,'Linewidth',2)
% plot3(orientation_plot,z(end,1),z(end,2),z(end,3),'sq','MarkerSize',15,'Linewidth',2)

hold(q0_plot,'on')
plot(q0_plot,q0,'Linewidth',2)

hold(q1_plot,'on')
plot(q1_plot,q1,'Linewidth',2)

hold(q2_plot,'on')
plot(q2_plot,q2,'Linewidth',2)

hold(q3_plot,'on')
plot(q3_plot,q3,'Linewidth',2)

end

function sgtitlesetup(TITLETEXT)

TITLE = sgtitle(TITLETEXT);

set( TITLE, ...
    'FontSize'   , 20, ...
    'Interpreter', 'latex' ...
   );

end

function titlesetup(TITLETEXT)

TITLE = title(TITLETEXT);

set( TITLE, ...
    'FontSize'   , 14, ...
    'Interpreter', 'latex' ...
   );

end

function axessetup(XLABTEXT,YLABTEXT,ZLABTEXT)

if nargin == 2

    XLAB = xlabel(XLABTEXT);
    YLAB = ylabel(YLABTEXT);

    set([XLAB, YLAB], ...
        'FontSize'   , 14 , ...
        'Interpreter', 'latex' );

    set(gca, ...
        'Box'        , 'on' , ...
        'TickDir'    , 'in' , ...
        'XMinorTick' , 'on' , ...
        'YMinorTick' , 'on' , ...
        'ZMinorTick' , 'on' , ...
        'LineWidth'  , 1 );
    
    view(2)

elseif nargin == 3
    
    XLAB = xlabel(XLABTEXT);
    YLAB = ylabel(YLABTEXT);
    ZLAB = zlabel(ZLABTEXT);

    set([XLAB, YLAB, ZLAB], ...
        'FontSize'   , 14 , ...
        'Interpreter', 'latex' );

    set(gca, ...
        'Box'        , 'on' , ...
        'TickDir'    , 'in' , ...
        'XMinorTick' , 'on' , ...
        'YMinorTick' , 'on' , ...
        'ZMinorTick' , 'on' , ...
        'LineWidth'  , 1 );
    
    view(3)
    
else

end

end
