% Samples velocity according to MB statistics
function velocities = sample_velocity(T,M,N, theta_min, theta_max, phi_min, phi_max, cutoff)
    velocities = zeros(N,3);
    theta = (theta_min-theta_max)*rand(N,1) + theta_max;
    phi = (phi_max-phi_min)*rand(N,1) + phi_min;
    a = (1.38*1e-23*T/M)^0.5;
    n = 0;
    while N > n 
        x1 = normrnd(0,a);
        x2 = normrnd(0,a);
        x3 = normrnd(0,a);
        v = (x1^2 + x2^2 + x3^2)^0.5;
        if v <= cutoff
        n = n +1;
        velocities(n,1) = v*sin(theta(n))*cos(phi(n));
        velocities(n,2) = v*sin(theta(n))*sin(phi(n));
        velocities(n,3) = v*cos(theta(n));
        end
    end    
end