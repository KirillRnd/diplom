function [ R , V ] = rungeKShort( h,iteration, R0,V0)

%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
R = zeros(3,iteration+1); %метры, в ИСК
V = zeros(3,iteration+1); %метры/сек в ИСК

R(:,1) = R0;
V(:,1) = V0;

%1-3 радиус вектор/ 4-6 скорость/ 7-9 угловая скорость/10-13 кватернион/
%/время i+1/(2..3)/
for i = 1:1:iteration+1 % [dot_R; dot_V]
k1=RungeFunctionShort(R(:,i),V(:,i),h*i);

k2=RungeFunctionShort(R(:,i)+h/2*k1(1:3),V(:,i)+h/2*k1(4:6),h*(i+1/2));

k3=RungeFunctionShort(R(:,i)+h/2*k2(1:3),V(:,i)+h/2*k2(4:6),h*(i+1/2));

k4=RungeFunctionShort(R(:,i)+h*k3(1:3),V(:,i)+h*k3(4:6),h*(i+1));

Y=h/6*(k1+2*k2+2*k3+k4);

R(:,i+1)=R(:,i)+Y(1:3);
V(:,i+1)=V(:,i)+Y(4:6);
end



end

