function [ f ] = RungeFunction( R,V,W,Q0,t )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
Q=quatnormalize(Q0')';
f = zeros (13,1);
f(1:3,1)=V;
f(4:6,1)=Fgrav(R);
f(7:9,1)=momentumgrav(R,V,W,Q,t);
f(10:13,1)=quatRunge(Q,W);
end

