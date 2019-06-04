function [Rnorm, Rnorm_tmp] = randomdist_tundra_func_R(R,grad_0,N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Rnew=R(:,1:N);%באחמגûו פאיכû

Rnorm_tmp=zeros(3,N);
for i=1:N
    Rnorm_tmp(:,i)=Rnew(:,i)/norm(Rnew(:,i));
end
%grad_0=1;
SS=grad_0*2*pi/360;
Rnorm=zeros(3,N);
for i=1:N-1
    Rnorm(:,i)=random_deviation(Rnorm_tmp(:,i)',cross(Rnorm_tmp(:,i),Rnorm_tmp(:,i+1)),SS);
end

    Rnorm(:,N)=random_deviation(Rnorm_tmp(:,N)',cross(Rnorm_tmp(:,N-1),Rnorm_tmp(:,N)),SS);
end

