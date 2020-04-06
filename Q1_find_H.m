close all
clear,clc;

standard = xlsread('CUMCM-2018-Problem-A-Chinese-Appendix.xlsx',2);
standard(:,1)=[];
h1 = 116.3024:0.00001:116.5;
errors = zeros(50,1);
%% 初始条件
Te=75;
l1=0.6/1000;l3=3.6/1000;% 四种材料厚度
l2=6/1000;
l4=5/1000;
lam_1=0.082;lam_2=0.37;lam_3=0.045;lam_4=0.028;% 四种材料的热传导率
n=5400;% 对时间分割
t=5400;% 总时长

%% 黄金分割求解h
% U_S = 37;U_E = 75;U_M = 47.8;% 计算H的参数
% a = 100;b = 140;eps = 1e-4; % 搜索的左右端点和误差允许范围
% 
% r = a+0.382*(b-a); u = a+0.618*(b-1);
% r_2 = 1/((U_M-U_S)/(U_E-U_M)*( 1/r + l1/lam_1+l2/lam_2+l3/lam_3+l4/lam_4));
% u_2 = 1/((U_M-U_S)/(U_E-U_M)*( 1/u + l1/lam_1+l2/lam_2+l3/lam_3+l4/lam_4));
% 
% while true
%     u_left = General_Simulation(Te,l2,l4,r,r_2,t,n);
%     u_right = General_Simulation(Te,l2,l4,u,u_2,t,n);
%     if u_left > u_right
%         if (b-r) <= eps
%             disp([r,b]);
%             break;
%         end
%         a=r;r=u;u=a+0.618*(b-a);
%         r_2 = 1/((U_M-U_S)/(U_E-U_M)*( 1/r + l1/lam_1+l2/lam_2+l3/lam_3+l4/lam_4));
%         u_2 = 1/((U_M-U_S)/(U_E-U_M)*( 1/u + l1/lam_1+l2/lam_2+l3/lam_3+l4/lam_4));
%     end
%     if u_left <= u_right
%         if (u-a) <= eps
%             disp([a,u]);
%             break;
%         end
%         b=u;u=r;r=a+(1-0.618)*(b-a);
%         r_2 = 1/((U_M-U_S)/(U_E-U_M)*( 1/r + l1/lam_1+l2/lam_2+l3/lam_3+l4/lam_4));
%         u_2 = 1/((U_M-U_S)/(U_E-U_M)*( 1/u + l1/lam_1+l2/lam_2+l3/lam_3+l4/lam_4));
%     end
% end

%% 计算误差
for index=1:size(h1,2)
    % h的关系式
    h_1 = h1(index);
    U_S = 37;U_E = 75;U_M = 47.8;% 计算H的参数
    h_2 = 1/((U_M-U_S)/(U_E-U_M)*( 1/h_1 + l1/lam_1+l2/lam_2+l3/lam_3+l4/lam_4));
    u = General_Simulation(Te,l2,l4,h_1,h_2,t,n);
    vector = u(153,:)';
    errors(index) = sqrt(sum((vector - standard).^2));
    if index>1
        if errors(index)>errors(index-1)
            break;
        end
    end
end
%% 绘制误差
plot(h1,errors,'LineWidth',1.5);
grid on
xlabel('环境空气导热系数','FontSize',12)
ylabel('误差平方和','FontSize',12)
axis([50 200 15 45]);
set(gca, 'LineWidth',1,'FontSize',12);