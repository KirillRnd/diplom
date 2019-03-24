function [rnew] = random_deviation(r,k,sigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
r1=cross(r,k);
r1 = r1 / norm(r1);
r1 = r1 * randn() * sigma;
phi=rand()*2*pi;
q=[cos(phi/2) r];
r1 = quatrotate(q, r1);
rnew=(r1+r)/norm(r1+r);
end

