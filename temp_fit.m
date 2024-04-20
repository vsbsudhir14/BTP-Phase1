function temp = temp_fit(velocities, m_Yb, kB)
    [p,x] = hist(velocities, 10000);
    model = @(a,x)(4*(a^3)*(x.^2).*exp(-1*a^2*(x.^2))/sqrt(pi));
    mp = rms(x);
    sigma= nlinfit(x,p,model,[1/mp]);
    temp = 1.5*m_Yb/((sigma*sigma)*2*kB);
end