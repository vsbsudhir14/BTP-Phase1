function dy = Force(t,y, x1, amax1, s0_1, gamma1, delta1, k1, Bp, x2, amax3, s0_3, gamma3, delta3, k3)
dy=zeros(6,1); 
         x = y(1);
         Y = y(3);
         z = y(5);
        dy(1,1) = y(2);
        dy(3,1) = y(4);
        dy(5,1) = y(6);
        r = sqrt(x^2 + Y^2 + z^2);
        if r > x1 && r <= x2
            dy(2,1)= amax1*(s0_1/(1+s0_1+(4/gamma1^2)*(delta1-k1*y(2)-Bp*y(1))^2)-s0_1/(1+s0_1+(4/gamma1^2)*(delta1+k1*y(2)+Bp*y(1))^2));
            dy(4,1) = amax1*(s0_1/(1+s0_1+(4/gamma1^2)*(delta1-k1*y(4)-Bp*y(3))^2)-s0_1/(1+s0_1+(4/gamma1^2)*(delta1+k1*y(4)+Bp*y(3))^2));
            dy(6,1) = amax1*(s0_1/(1+s0_1+(4/gamma1^2)*(delta1-k1*y(6)-2*Bp*y(5))^2)-s0_1/(1+s0_1+(4/gamma1^2)*(delta1+k1*y(6)+2*Bp*y(5))^2));
        elseif r <= x1
            dy(2,1)=amax3*(s0_3/(1+s0_3+(4/gamma3^2)*(delta3-k3*y(2)-Bp*y(1))^2)-s0_3/(1+s0_3+(4/gamma3^2)*(delta3+k3*y(2)+Bp*y(1))^2));
            dy(4,1)=amax3*(s0_3/(1+s0_3+(4/gamma3^2)*(delta3-k3*y(4)-Bp*y(3))^2)-s0_3/(1+s0_3+(4/gamma3^2)*(delta3+k3*y(4)+Bp*y(3))^2));
            dy(6,1)=amax3*(s0_3/(1+s0_3+(4/gamma3^2)*(delta3-k3*y(6)-2*Bp*y(5))^2)-s0_3/(1+s0_3+(4/gamma3^2)*(delta3+k3*y(6)+2*Bp*y(5))^2));
        else
        dy(2,1) = 0;
        dy(4,1) = 0;
        dy(6,1) = 0;
        end
end
   
    