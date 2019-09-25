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

%1st derivative
yapp1=gradient(y,h);

figure;
plot(x,y,'ro');
legend('original');
export_fig original.pdf -native % -nocrop
%plot(x,yapp1,'g');
%plot(h001diff(:,1),h001diff(:,2),'p')

%2nd derivative
yapp2=4*del2(y, h);
%plot(x,yapp2,'b');
%plot(h001diffdiff(:,1),h001diffdiff(:,2),'p');

%curvature
k=yapp2./(1+yapp1.^2).^(3/2);
figure;
hold on;
plot(x,k,'r');
plot(h001curvature(:,1),h001curvature(:,2),'p');
xlim([0.0002 0.0018]);
legend('matlab numerical','c++');
export_fig numerical_curvature.pdf -native % -nocrop
%legend('yapp2','diffdiff');
%legend('dosh0.001','1st','2nd');

%y=diff(h001(:,2),1)/(h001(2,1)-h001(1,1));
%x=(1:1:length(y))*h001(1,1)/10;

%plot(h001diff(:,1),h001diff(:,2))
