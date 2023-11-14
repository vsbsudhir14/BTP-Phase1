clc;
clear all;
close all;
gamma=28e6;%For Yb
k=1/399e-9;
xin=-1;
vin=5.4*gamma/k
% t_s=1/gamma
Y1=[xin vin];%Initial values of postion and velocity
% timespan1=[0:t_s:10*t_s];
% 
timespan1=linspace(0,3,100);
[T,Y] = ode45(@pos_vel,timespan1,(Y1),[]);
pos1=Y(:,1);
vel1=Y(:,2);
% max_v=max(vel1)
% max_x=max(pos1)
%disp(vel1)
figure;
subplot(2,1,1);
plot(T,pos1,'*-r')
xlabel('Time (s)');
ylabel('Position (cm)');
title('Numerical Solution: Position');

subplot(2,1,2);
plot(T,vel1*k/gamma,'o-')
xlabel('Time (s)');
ylabel('Velocity (cm/s)');
title('Numerical Solution: Velocity');
% subplot(2,1,1);
figure
plot(pos1,vel1*k/gamma,'*-g')
xlabel('position(cm)');
ylabel('velocity (cm/s)');
