clc;
clear all;
close all;
% Define the parameters for x
w1=2;% beam waist in cm
Is1=58; %mW/cm^2 satruration intensity
P1=100;%mw
Ip1=2*P1/(pi*(w1/2)^2); %INTENSITY ON THE MOT
so1=Ip1/Is1;% so = I/I_saturation
MueB=1.4e6;
h=6.6e-34;
gamma=28*1e6;    % decay rate 
delta1=-gamma;% detuning
Bz1=7;         % magnetic field gradient in Guass/cm
lambda1=399e-9; % wavelength
k1 =1/lambda1;  % wavevector 
Bp1=MueB*Bz1;
m_Yb=174*1.67e-27;
amax1=h*k1*gamma/(2*m_Yb);
xin=-1;
flag = true;
v1 = 0;

        tic;
        odeSystemx=@(t,x)[x(2);amax1*so1*(1/(1+so1+((2*(delta1-k1*x(2)-Bp1*x(1)))/gamma)^2)-1/(1+so1+(2*((delta1+k1*x(2)+Bp1*x(1))/gamma))^2))];
        while flag
            v1=v1 + 0.01;
            
            n=1000;% no of points
            tspan=linspace(0,10,n); % Start at 0 and integrate up to 30 seconds
            
            % Initial conditions
            initialConditionsx=[xin;v1];  % x(0) = 0, dx/dt(0) = 0
            % Define the function for the ODE system
            % x(1) represents x(t), x(2) represents dx/dt
            
            % Solve the ODE numerically using ode45
            [t,solx]=ode45(odeSystemx,tspan,initialConditionsx);
            
            % Extract the solution
            xNumerical=solx(:,1);
            xDotNumerical=solx(:,2);
            
            
            
            max_x=max(abs(xNumerical));
            if max_x>w1/2
                flag = false;
            end
        end
        toc;
        disp(v1)
