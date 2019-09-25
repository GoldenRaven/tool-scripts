close all;
clear all;

datapath1='h001';
load(datapath1,'h001');

datapath2='h001diff';
load(datapath2,'h001diff');

datapath3=('h001diffdiff');
load(datapath3,'h001diffdiff');

datapath4=('h001curvature');
load(datapath4,'h001curvature');

x=h001(:,1);
y=h001(:,2);
h=abs(diff([x(2,1),x(1,1)]));
plot(x,y,'o')
%% spline拟合
pp = csape(x, y);
%% 拟合图
hold on
plot( x, fnval(pp, x), 'g' );
legend('original', 'Spline fitting')
export_fig original_fitting.pdf -native % -nocrop
%saveas(gcf,['original_fitting.pdf']);
%% 求导
pp1 = fnval(fnder(pp, 1), x); %求一阶导
pp2 = fnval(fnder(pp, 2), x); %求二阶导
%% 曲率，K = |y''| / ((1 + y'^2)^(3/2))

curvature = pp2 ./ sqrt( (1 + pp1 .^ 2) .^ 3 );
%% 曲率图
figure
hold on
plot( x, curvature, 'r' );
plot(h001curvature(:,1),h001curvature(:,2),'p');
%% 图例
legend('c++','matlab fitting curvature');
xlim([0.0002 0.0018]);
%% 显示网格
grid on
%saveas(gcf,['fitting_curvature.pdf']);
export_fig fitting_curvature.pdf -native % -nocrop
