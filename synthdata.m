numdata = 100;

t = linspace(0,pi,numdata);
ang1 = linspace(0,90,numdata);
ang2 = linspace(0,45,numdata);

x1 = linspace(0,1,numdata);
y1 = zeros(1,numdata);
z1 = sin(t);

pos1 = [x1; y1; z1];
pos2 = RotZ(60)*pos1*0.5;

for i = 1:length(ang1)
    orient1(:,:,i) = RotZ(ang1(i));
end

for i = 1:length(ang2)
    orient2(:,:,i) = RotZ(ang2(i));
end

figure(1)
plot3(pos1(1,:),pos1(2,:),pos1(3,:),'k-','LineWidth',1)
hold on
plot3(pos2(1,:),pos2(2,:),pos2(3,:),'k-','LineWidth',1)

figure(2)
plot3(pos1(1,:),pos1(2,:),pos1(3,:),'k-','LineWidth',1)
hold on
plot3(pos2(1,:),pos2(2,:),pos2(3,:),'k-','LineWidth',1)

for j = 1:numdata
    plot3([pos1(1,j)  pos1(1,j)+0.05*orient1(1,1,j)],[pos1(2,j)  pos1(2,j)+0.05*orient1(2,1,j)],[pos1(3,j)  pos1(3,j)+0.05*orient1(3,1,j)],'r-','LineWidth',1)
    plot3([pos1(1,j)  pos1(1,j)+0.05*orient1(1,2,j)],[pos1(2,j)  pos1(2,j)+0.05*orient1(2,2,j)],[pos1(3,j)  pos1(3,j)+0.05*orient1(3,2,j)],'g-','LineWidth',1)
    plot3([pos1(1,j)  pos1(1,j)+0.05*orient1(1,3,j)],[pos1(2,j)  pos1(2,j)+0.05*orient1(2,3,j)],[pos1(3,j)  pos1(3,j)+0.05*orient1(3,3,j)],'b-','LineWidth',1)
    
    plot3([pos2(1,j)  pos2(1,j)+0.05*orient2(1,1,j)],[pos2(2,j)  pos2(2,j)+0.05*orient2(2,1,j)],[pos2(3,j)  pos2(3,j)+0.05*orient2(3,1,j)],'r-','LineWidth',1)
    plot3([pos2(1,j)  pos2(1,j)+0.05*orient2(1,2,j)],[pos2(2,j)  pos2(2,j)+0.05*orient2(2,2,j)],[pos2(3,j)  pos2(3,j)+0.05*orient2(3,2,j)],'g-','LineWidth',1)
    plot3([pos2(1,j)  pos2(1,j)+0.05*orient2(1,3,j)],[pos2(2,j)  pos2(2,j)+0.05*orient2(2,3,j)],[pos2(3,j)  pos2(3,j)+0.05*orient2(3,3,j)],'b-','LineWidth',1)
end
%axis square

positions{1} = pos1;
positions{2} = pos2;

orientations{1} = quaternion(orient1, 'rotmat', 'frame')';
orientations{2} = quaternion(orient2, 'rotmat', 'frame')';

avgpos = simpleDBA(positions);
avgquat = simpleDBA(orientations,'quaternion');

avgorient = rotmat(avgquat,'point');

figure(1)
plot3(avgpos(1,:),avgpos(2,:),avgpos(3,:),'k','LineWidth',2)

title('Position Only')
set(gca,'DataAspectRatio',[1 1 1])
xlabel('x')
ylabel('y')
zlabel('z')

figure(2)
plot3(avgpos(1,:),avgpos(2,:),avgpos(3,:),'k','LineWidth',2)

for j = 1:numdata
    plot3([avgpos(1,j)  avgpos(1,j)+0.05*avgorient(1,1,j)],[avgpos(2,j)  avgpos(2,j)+0.05*avgorient(2,1,j)],[avgpos(3,j)  avgpos(3,j)+0.05*avgorient(3,1,j)],'r','LineWidth',2)
    plot3([avgpos(1,j)  avgpos(1,j)+0.05*avgorient(1,2,j)],[avgpos(2,j)  avgpos(2,j)+0.05*avgorient(2,2,j)],[avgpos(3,j)  avgpos(3,j)+0.05*avgorient(3,2,j)],'g','LineWidth',2)
    plot3([avgpos(1,j)  avgpos(1,j)+0.05*avgorient(1,3,j)],[avgpos(2,j)  avgpos(2,j)+0.05*avgorient(2,3,j)],[avgpos(3,j)  avgpos(3,j)+0.05*avgorient(3,3,j)],'b','LineWidth',2)
end

title('Position And Orientation')
set(gca,'DataAspectRatio',[1 1 1])
xlabel('x')
ylabel('y')
zlabel('z')

function Rz = RotZ(angle)

Rz = [ cosd(angle) -sind(angle) 0;
       sind(angle) cosd(angle) 0;
       0 0 1    ];
end