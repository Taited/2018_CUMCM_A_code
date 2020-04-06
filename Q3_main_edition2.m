close all;
clear,clc;

%% 初始条件
Te=80;
l1=0.6/1000;l3=3.6/1000;% 四种材料厚度
lam_1=0.082;lam_2=0.37;lam_3=0.045;lam_4=0.028;% 四种材料的热传导率
n=30*60;% 对时间分割
t=30*60;% 总时长
h_1 = 116.3024;
h_2 = 8.6635;
core = 0.6; % 人的圆柱模拟设置为1.8m

%% 设置材料Ⅱ、Ⅳ的搜索步长
l4 = 0.6:0.1:6.4; % 对应下面的角标j
l4 = l4/1000;
l2 = 0.6:0.1:25; % 对应下面的角标i
l2 = l2/1000;

%% 计算温度分布            
temperature = zeros(size(l2,2),size(l4,2),2);
for i=1:size(l2,2)
    for j=1:size(l4,2)
        u = General_Simulation(Te,l2(i),l4(j),h_1,h_2,t,n);
        temperature(i,j,1) = u(end,end);
        temperature(i,j,2) = u(end,end-5*60);
    end
end
[x,y] = meshgrid(l4*1000,l2*1000);
stand = 47*ones(size(l2,2),size(l4,2));
surf(x,y,temperature(:,:,1));
hold on
plot3(x,y,stand,'r')
shading interp

xlabel('Ⅳ层厚度/mm','FontSize',12)
ylabel('Ⅱ层厚度/mm','FontSize',12)
zlabel('皮肤温度/C°','FontSize',12)
title('第30分钟皮肤温度','FontSize',12);
set(gca, 'LineWidth',1,'FontSize',12);

%% 计算可行解
% load temperature
mask = temperature(:,:,2)<=44;
v = zeros(sum(sum(mask)),3);
index=0;
for i=1:size(mask,1)
    for j=1:size(mask,2)
        if mask(i,j)~= 0
            index=index+1;
            v(index,1)=CalcuVolume(l1,l2(i),l3,l4(j),core);
            v(index,2)=l2(i);v(index,3)=l4(j);
        end
    end
end
[~,index]=min(v(:,1));% 得到成本最小的点