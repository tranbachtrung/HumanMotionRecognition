function [] = quatVis(quat)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[q0,q1,q2,q3] = parts(quat);
x = rotatepoint(quat,[1 0 0]);
y = rotatepoint(quat,[0 1 0]);
z = rotatepoint(quat,[0 0 1]);

figure
titletext = {'Quaternion Visualization'};
sgtitlesetup(titletext)
set(gcf, 'Position', get(0, 'Screensize'));

orientationplot = subplot(2,4,[1 2 5 6]);
hold on
[sx,sy,sz] = sphere;
mesh(sx,sy,sz,'edgecolor','k','FaceAlpha',0,'EdgeAlpha',0.1)
plot3(x(1,1),x(1,2),x(1,3),'rp','MarkerSize',15,'Linewidth',2)
plot3(y(1,1),y(1,2),y(1,3),'gp','MarkerSize',15,'Linewidth',2)
plot3(z(1,1),z(1,2),z(1,3),'bp','MarkerSize',15,'Linewidth',2)
plot3(x(:,1),x(:,2),x(:,3),'r.','MarkerSize',10,'Linewidth',2)
plot3(y(:,1),y(:,2),y(:,3),'g.','MarkerSize',10,'Linewidth',2)
plot3(z(:,1),z(:,2),z(:,3),'b.','MarkerSize',10,'Linewidth',2)
plot3(x(end,1),x(end,2),x(end,3),'rsq','MarkerSize',15,'Linewidth',2)
plot3(y(end,1),y(end,2),y(end,3),'gsq','MarkerSize',15,'Linewidth',2)
plot3(z(end,1),z(end,2),z(end,3),'bsq','MarkerSize',15,'Linewidth',2)
titletext = '3D Quaternion Representation';
xlabeltext = '$x$';
ylabeltext = '$y$';
zlabeltext = '$z$';
titlesetup(titletext)
axessetup(xlabeltext,ylabeltext,zlabeltext)
    
q0_plot = subplot(2,4,3)
hold on
plot(q0,'b','Linewidth',2)
ylim([-1 1])
titletext = 'Magnitude Component';
xlabeltext = 'index';
ylabeltext = 'value';
titlesetup(titletext)
axessetup(xlabeltext,ylabeltext)  

q1_plot = subplot(2,4,4)
hold on
plot(q1,'b','Linewidth',2)
ylim([-1 1])
titletext = 'i-Component ';
xlabeltext = 'index';
ylabeltext = 'value';
titlesetup(titletext)
axessetup(xlabeltext,ylabeltext) 

q2_plot = subplot(2,4,7)
hold on
plot(q2,'b','Linewidth',2)
ylim([-1 1])
titletext = 'j-Component';
xlabeltext = 'index';
ylabeltext = 'value';
titlesetup(titletext)
axessetup(xlabeltext,ylabeltext) 

q3_plot = subplot(2,4,8)
hold on
plot(q3,'b','Linewidth',2)
ylim([-1 1])
titletext = 'k-Component';
xlabeltext = 'index';
ylabeltext = 'value';
titlesetup(titletext)
axessetup(xlabeltext,ylabeltext) 

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
