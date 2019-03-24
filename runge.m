function Dy = runge(t,y)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Dy=y(:);
G = 6.67428;
M = 5.972E24;
%Dy(1) = y(2);
%Dy(2) = -G*M*(y(1))^(-2);
Dy(1) = y(2);
Dy(2) =  - 4*y(1);
end

