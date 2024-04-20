T = 673; %Temperature of Oven (Source)
cloud_radius = 0.5;
cutoff = 150; %Cutoff Velocity
gamma1=28e6;
gamma3=0.18e6;


w1=2.0;% beam waist of singlet in cm
P1=100;%mw
delta1=-gamma1;
B=5;% Magnetic field gardient G/cm
w3=0.2;% beam waist of triplet in cm
P3=2;%mw
delta3=-20*gamma3;



m_Yb=174*1.67e-27; %mass
kB = 1.38*1e-23;
h=6.6e-34;
MueB=1.4e6; %1.4 MHZ/Gauss  
Bp=MueB*B;

%this is for singlet transition
Is1=58; %mW/cm^2 satruration intensity
Ip1=2*P1/(pi*(w1/2)^2); %INTENSITY ON THE MOT
s0_1=Ip1/Is1;% so = I/I_saturation
% s0_1=0.4;
lambda1=399e-9;
k1=1/lambda1;
amax1=(h/(m_Yb*lambda1)*gamma1/2);

%this is triplet transtion
Is3=0.14; %mW/cm^2 satruration intensity
Ip3=2*P3/(pi*(w3/2)^2); %INTENSITY ON THE MOT
s0_3=Ip3/Is3;% so = I/I_saturation
% s0_3=0.8; % saturation intensity
lambda3=556e-9;
k3=1/lambda3;
amax3=(h/(m_Yb*lambda3)*gamma3/2);

x1=w3/2;%radius of the triplet beam
x2=w1/2; % radius of the signlet beam


theta_min = pi/2 -2*pi*15/180;
theta_max = pi/2 + 2*pi*15/180;
phi_min= -2*pi*15/180;
phi_max = 2*pi*15/180;

N = 1e3;

t = 3; %Total simulation time
dt = 0.01; % Time step
mot_v = zeros(N,1);

%velocities = sample_velocity(T, m_Yb, N, theta_min, theta_max, phi_min, phi_max, cutoff);
%save('velocities.mat','velocities')
data = matfile('velocities.mat');
velocities = data.velocities;

%v = zeros(N,1);
%for i = 1 : N
%    v(i) = sqrt(velocities(i,1)^2 + velocities(i,2)^2 + velocities(i,3)^2);
%end
%[p,x] = hist(v, 1000);

%figure(1);
%plot(x,p);
%xlabel('Velocity ($\frac{m}{s}$)', Interpreter='latex');
%ylabel('Count')
%title('Velocity Distribution at T = '+string(T)+'K')
%Temperature = temp_fit(v,m_Yb,kB);
%disp(Temperature)

pos = sample_position(N, x1, cloud_radius);
%figure(2);
%scatter(pos(:,2), pos(:,3))
%xlabel('Y axis (cm)');
%ylabel('Z axis (cm)')
%title('Atomic Source Position before MOT')


timespan=linspace(0,t,t/dt);
Ncap = 0;

        for i = 1 : N
            %disp(i)
            y0 = [pos(i,1) velocities(i,1) pos(i,2) velocities(i,2) pos(i,3) velocities(i,3)];
            [T,Y] = ode45(@(t,y) Force(t,y, x1, amax1, s0_1, gamma1, delta1, k1, Bp, x2, amax3, s0_3, gamma3, delta3, k3),timespan, y0);
            if abs(Y(t/dt,1)) > x2 || abs(Y(t/dt,3)) > x2 || abs(Y(t/dt,5)) > x2
            mot_v(i) = 0;
            else
                mot_v(i) = sqrt(Y(t/dt,2)^2 + Y(t/dt,4)^2 + Y(t/dt,6)^2);
                Ncap = Ncap + 1;
            end
        end
        disp(Ncap)
toc;    
%    disp(temp_fit(mot_v, m_Yb, kB))
