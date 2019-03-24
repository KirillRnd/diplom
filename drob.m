clc;
clear;
a = zeros(6,320);
% a(1,1:320)=rand(1,320);
a(1,1:320)=1:320;
for i = (1:5)
    n=10*(2^(5-i));
    for j = (1:2^(i-1))
        b=((j-1)*2*n+1):j*n;
        c=j*2*n+1:(j+1)*n;
        k=floor(j/2);
        b2=(k*n+1):2:(k+2)*n;
        c2=(k*n+2):2:(k+2)*n;
        a(i+1,b)=(a(i,b2)+a(i,c2))/2;
        a(i+1,c)=(a(i,b2)-a(i,c2))/2;
    end
end