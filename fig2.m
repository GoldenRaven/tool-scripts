%data = importdata('../plot/fig2/gamma0=0.0001.dat');  
%plot(data);  
%saveas(gcf,['./','test','.jpg']);   
close all;
clear all;

datapath1='aa.dat';
load(datapath1,'aa');
datapath2='bb.dat';
load(datapath2,'bb');
datapath3='cc.dat';
load(datapath3,'cc');
datapath4='dd.dat';
load(datapath4,'dd');

h = figure('visible','off');
set(0,'CurrentFigure',h);
figure1 = figure;
subplot1 = subplot(1,2,1,'Parent',figure1,'LineWidth',2,'FontSize',30,...
    'XTick',[-0.03 -0.015 0 0.015 0.03],...
    'FontName','Times New Roman');
box(subplot1,'on');
hold(subplot1,'all');
plot(aa(:,1),aa(:,4),'Parent',subplot1,'LineWidth',2,'Color',[0 0 0],...
    'DisplayName','\Gamma_0h=0');
plot(bb(:,1),bb(:,4),'Parent',subplot1,'LineWidth',2,'Color',[1 0 0],...
    'DisplayName','\Gamma_0h=0.05');
plot(cc(:,1),cc(:,4),'Parent',subplot1,'LineWidth',2,'Color',[0 1 0],...
    'DisplayName','\Gamma_0h=0.1');
plot(dd(:,1),dd(:,4),'Parent',subplot1,'LineWidth',2,'Color',[0 0 1],...
    'DisplayName','\Gamma_0h=0.15');
xlim(subplot1,[-0.03 0.03]);
ylim(subplot1,[-0.001 0.6]);
xlabel('\omega','FontSize',30,'FontName','Times New Roman');
ylabel('DOS','FontSize',30,'FontName','Times New Roman');
legend1 = legend(subplot1,'show');
set(legend1,...
    'Position',[0.235941368920686 0.751210601007483 0.128900304414003 0.161756607929516],...
    'LineWidth',2,...
    'FontSize',20);
	%'FontSize',20,'EdgeColor',[1,1,1]);
%axis([-0.7 0.7 -3.475 -3.075])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datapath='a.dat';
load(datapath,'a');
datapath='b.dat';
load(datapath,'b');
datapath='c.dat';
load(datapath,'c');
datapath='d.dat';
load(datapath,'d');

subplot2 = subplot(1,2,2,'Parent',figure1,...
    'XTick',[1e-05 1e-04 1e-03 1e-02 1e-01 1],...
    'XScale','log',...
    'XMinorTick','on',...
    'LineWidth',2,...
    'FontSize',30,...
    'FontName','Times New Roman');
xlim(subplot2,[1e-5 1]);
ylim(subplot2,[-0.1 2]);
box(subplot2,'on');
hold(subplot2,'all');
semilogx(a(:,1),a(:,2),'Parent',subplot2,'MarkerSize',25,'LineWidth',2,'DisplayName','\Gamma_0h=0','Color',[0 0 0])
semilogx(b(:,1),b(:,2),'Parent',subplot2,'MarkerSize',25,'LineWidth',2,'Color',[0 0 1],'DisplayName','\Gamma_0h=0.05')
semilogx(c(:,1),c(:,2),'Parent',subplot2,'MarkerSize',25,'LineWidth',2,'Color',[0 1 0],'DisplayName','\Gamma_0h=0.1')
semilogx(d(:,1),d(:,2),'Parent',subplot2,'MarkerSize',25,'LineWidth',2,'Color',[1 0 0],'DisplayName','\Gamma_0h=0.15')
set(gca,'linewidth',2)
xlabel('T','FontSize',30,'FontName','Times New Roman');
ylabel('S_{imp}/ln2','FontSize',30,'FontName','Times New Roman');
legend2 = legend(subplot2,'show');
set(legend2,...
    'Position',[0.700900996048645 0.731193897166483 0.0873305526590198 0.15625],...
    'LineWidth',2,...
    'FontSize',20);

annotation(figure1,'textbox',...
    [0.143129238824207 0.858672898010338 0.0380604796663191 0.0563829787234043],...
    'String',{'(a)'},...
    'FontSize',25,...
    'FontName','Times New Roman',...
    'EdgeColor',[1 1 1]);
annotation(figure1,'textbox',...
    [0.587453424398498 0.854603722018476 0.0391032325338895 0.0563829787234043],...
    'String',{'(b)'},...
    'FontSize',25,...
    'FontName','Times New Roman',...
    'EdgeColor',[1 1 1]);
%subplot(122);
%plot(fig1b(:,1),fig1b(:,2),'g--')
%plot(fig1a1(:,1),fig1a1(:,2),'b--',fig1a2(:,1),fig1a2(:,2),'r--',fig1a3(:,1),fig1a3(:,2),'g--')
%hold on
%xlabel('\delta/U');
%ylabel('\Gamma_0/U');
%saveas(gcf,['./','fig2','.jpg']);   
