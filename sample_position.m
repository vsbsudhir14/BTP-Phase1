%Samples an atomic cloud source

function pos = sample_position(N,x0,cloud_radius)
    x = -1*x0*ones(N,1);
    r = cloud_radius*(rand(N,1)); 
    theta = 2*pi*rand(N,1);
    [y, z] = pol2cart(theta, r);
    pos = [x,y,z];
end
