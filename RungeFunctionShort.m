function [ f ] = RungeFunctionShort( R,V,t )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
f = zeros (6,1);
f(1:3,1)=V;
f(4:6,1)=Fgrav(R);
%f(4:6,1)=GetGravityFromTime(t,R);
end
