close all;
clear,clc;

%% 初始条件
Te=80;
l1=0.6/1000;l3=3.6/1000;% 四种材料厚度
l4=6.4/1000;
lam_1=0.082;lam_2=0.37;lam_3=0.045;lam_4=0.028;% 四种材料的热传导率
n=30*60;% 对时间分割
t=30*60;% 总时长
h_1 = 116.3024;
h_2 = 8.6635;
%% 二分法查找温度为47
left = 0.6; right = 25;
T=47; eps = 1e-4;
while (left <= right)
    middle = (left+right)/2;
    u = General_Simulation(Te,middle/1000,l4,h_1,h_2,t,n);
    temp = u(153,t);
    if abs(temp-T)<eps
        break;
    end
    if temp>T
        left = middle;
    end
    if temp<T
        right = middle;
    end
end
temp_47=middle;
%% 二分法查找温度为44
left = temp_47; right = 25;
T=44; eps = 1e-4;
while (left <= right)
    middle = (left+right)/2;
    u = General_Simulation(Te,middle/1000,l4,h_1,h_2,t,n);
    temp = u(153,t-300);% 找到倒数的第5min
    if abs(temp-T)<eps
        break;
    end
    if temp>T
        left = middle;
    end
    if temp<T
        right = middle;
    end
end
temp_44=middle;
%% 先画图看看
l2 = 0.6:0.1:25;
l2 = l2/1000;
temperature = zeros(size(0.6:0.1:25,2),2);
for i=1:size(0.6:0.1:25,2)
    u = General_Simulation(Te,l2(i),l4,h_1,h_2,t,n);
    temperature(i,1) = u(153,t);
    temperature(i,2) = u(153,t-300);
end
%% 绘图部分
subplot(2,1,1)
plot(l2*1000,temperature(:,1),'LineWidth',1.5)
grid on
axis([0 25 40 49]);
xlabel('Ⅱ层厚度/mm','FontSize',12)
ylabel('皮肤温度/C°','FontSize',12)
title('第30分钟皮肤温度','FontSize',12);
hold on
plot(temp_47,47,'r*','LineWidth',1.5);
legend('温度曲线','温度极限点')
set(gca, 'LineWidth',1,'FontSize',12);

subplot(2,1,2)
plot(l2*1000,temperature(:,2),'LineWidth',1.5)
grid on
axis([0 25 40 49]);
xlabel('Ⅱ层厚度/mm','FontSize',12)
ylabel('皮肤温度/C°','FontSize',12)
title('第25分钟皮肤温度','FontSize',12);
hold on
plot(temp_44,44,'r*','LineWidth',1.5);
legend('温度曲线','最优点')
set(gca, 'LineWidth',1,'FontSize',12);