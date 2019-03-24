function [d] = normR4hiter(h,iter, r0,V0)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[R,V]=rungeKShort( h,iter, r0,V0);
N = iter;
Rnorm_tmp=zeros(3,iter);
for i=1:N
    Rnorm_tmp(:,i)=R(:,i+1)/norm(R(:,i+1));
end
d=Rnorm_tmp;
end

