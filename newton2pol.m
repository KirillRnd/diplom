function [ a ] = newton2pol(b,x0)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%для корректной работы x должен быть на 1 меньше  по длине
N=length(b)-1;
a=zeros(1,N+1);
x=-x0;
P=zeros(N);
P(1,1)=x(1);
j=1;
for i=1:N-1
    P(j,i+1)=P(j,i)+x(i+1);
end

for j=2:N-1
    P(j,j)=P(j-1,j-1)*x(j);
    for i=j:N-1
        P(j,i+1)=P(j,i)+P(j-1,i)*x(i+1);
    end
end
P(N,N)=P(N-1,N-1)*x(N);
P;
b2=zeros(1,N+1);
for i=1:N
    for j=i+1:N+1
        b2(i)=b2(i)+b(j)*P(j-i,j-1);
    end
end
b2;
a=b+b2;
end

