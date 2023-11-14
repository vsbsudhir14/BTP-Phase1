function dy = pos_vel(t,y)
% ++++++++++++++++++++++++++++++
%For Yb
mYb=174*1.67e-27;
h=6.6e-34;
MueB=1.4e6; %1.4 MHZ/Gauss  
B=5;% Magnetic field gardient G/cm
Bp=MueB*B;
%this is for singlet transition
w1=2.0;% beam waist in cm
Is1=58; %mW/cm^2 satruration intensity
P1=100;%mw
Ip1=2*P1/(pi*(w1/2)^2); %INTENSITY ON THE MOT
s0_1=Ip1/Is1;% so = I/I_saturation
gamma1=28e6;
% s0_1=0.4;
delta1=-gamma1;
lambda1=399e-9;
k1=1/lambda1;
amax1=(h/(mYb*lambda1)*gamma1/2);
%this is triplet transtion
w3=0.2;% beam waist in cm
Is3=0.14; %mW/cm^2 satruration intensity
P3=2;%mw
Ip3=2*P3/(pi*(w3/2)^2); %INTENSITY ON THE MOT
s0_3=Ip3/Is3;% so = I/I_saturation
% s0_3=0.8; % saturation intensity
gamma3=0.18e6;
delta3=-20*gamma3;
lambda3=556e-9;
k3=1/lambda3;
amax3=(h/(mYb*lambda3)*gamma3/2);

x1=w3/2;%radius of the triplet beam
x2=w1/2; % radius of the signlet beam
% ==========================================
dy=zeros(2,1); 
    dy(1,1)=y(2);
         x = y(1);
    if  x2 >= x && x >= x1 || -x2 <= x && x <= -x1 % if the the atom enters to the region [x2 to x1] and [-x1 to -x2] in which force given by singlet beam
    s0_3_n = s0_3*exp(-x^2/w3^2);
    dy(2,1)=amax1*(s0_1/(1+s0_1+(4/gamma1^2)*(delta1-k1*y(2)-Bp*y(1))^2)-s0_1/(1+s0_1+(4/gamma1^2)*(delta1+k1*y(2)+Bp*y(1))^2)) + amax3*(s0_3_n/(1+s0_3_n+(4/gamma3^2)*(delta3-k3*y(2)-Bp*y(1))^2)-s0_3_n/(1+s0_3_n+(4/gamma3^2)*(delta3+k3*y(2)+Bp*y(1))^2));
%    dy(2,1)=amax1*(s0_1/(1+s0_1+(4/gamma1^2)*(delta1-k1*y(2)-Bp*y(1))^2)-s0_1/(1+s0_1+(4/gamma1^2)*(delta1+k1*y(2)+Bp*y(1))^2));
    elseif x > -x1 && x < x1 % if the the atom enters to the region  [x1 to -x1] in which force given by exerted by triplet beam
      dy(2,1)=amax3*(s0_3/(1+s0_3+(4/gamma3^2)*(delta3-k3*y(2)-Bp*y(1))^2)-s0_3/(1+s0_3+(4/gamma3^2)*(delta3+k3*y(2)+Bp*y(1))^2));
    else % the atom out of the trap there is no force on it
          dy(2,1)=0;
          'atom out of the trap';
%           v_ev=y(2)
    end
   
    