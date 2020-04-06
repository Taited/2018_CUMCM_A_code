close all
clear,clc

d=0.05;
[x,y,z]=meshgrid(0:d:4,-2:d:2,-2:d:3);
v=x.^2/4+y.^2/4+z.^2/4-x;
p=isosurface(x,y,z,v,0);
 
fz=@(x,y) (307620*x)/2908093 + (10070*y)/28793 + 671042474/363511625;
[xx yy]=meshgrid(0:d:4,-2:d:2);
zz=fz(xx,yy);
 
f=@(x,y) x.^2/4+y.^2/4+(fz(x,y)).^2/4-x;
c=contours(xx,yy,f(xx,yy),[0 0]);
xxx=c(1,2:end);yyy=c(2,2:end);
zzz=fz(xxx,yyy);
 
mesh(xx,yy,zz,'edgecolor','none','facecolor','r','facealpha',0.3);hold on
patch(p,'edgecolor','none','facecolor','b','facealpha',0.3);
plot3(xxx,yyy,zzz,'k','linewidth',1);hold off
axis equal;