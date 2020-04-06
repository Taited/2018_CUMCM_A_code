close all;
clear,clc;

%% 初始条件
Te=65;
l1=0.6/1000;l3=3.6/1000;% 四种材料厚度
l4=5.5/1000;
lam_1=0.082;lam_2=0.37;lam_3=0.045;lam_4=0.028;% 四种材料的热传导率
n=60*60;% 对时间分割
t=60*60;% 总时长
h_1 = 116.3024;
h_2 = 8.6635;
%% 二分法
left = 0.6;right = 25;
T=44;
while (left <= right)
    middle = (left+right)/2;
    u = General_Simulation(Te,middle/1000,l4,h_1,h_2,t,n);
    temp = u(153,t-300);% 找到倒数的第5min
    if abs(temp-T)<(0.0000001)
        break;
    end
    if temp>T
        left = middle;
    end
    if temp<T
        right = middle;
    end
end
%% 画图的程序
l2 = 0.6:0.1:25;
l2 = l2/1000;
temperature = zeros(size(0.6:0.1:25,2),2);
for i=1:size(0.6:0.1:25,2)
    u = General_Simulation(Te,l2(i),l4,h_1,h_2,t,n);
    temperature(i,1) = u(153,t);
    temperature(i,2) = u(153,t-300);
end

%% 绘图
subplot(2,1,1)
plot(l2*1000,temperature(:,1),'LineWidth',1.5)
grid on
xlabel('Ⅱ层厚度/mm','FontSize',12)
ylabel('皮肤温度/C°','FontSize',12)
title('第60分钟皮肤温度','FontSize',12);
legend('温度曲线')
set(gca, 'LineWidth',1,'FontSize',12);

subplot(2,1,2)
plot(l2*1000,temperature(:,2),'LineWidth',1.5)
grid on
xlabel('Ⅱ层厚度/mm','FontSize',12)
ylabel('皮肤温度/C°','FontSize',12)
title('第55分钟皮肤温度','FontSize',12);
set(gca, 'LineWidth',1,'FontSize',12);
hold on
plot(temp_44,44,'r*','LineWidth',1.5);
legend('温度曲线','最优点')

% u = Simulation(middle/1000,3600,3600);%总共6min，分成3600秒
% subplot(3,1,3)
% plot(u(153,:),'LineWidth',1.5);
% grid on
% xlabel('时间/s','FontSize',12)
% ylabel('皮肤温度/C°','FontSize',12)
% set(gca, 'LineWidth',1,'FontSize',12);
% legend('温度曲线')