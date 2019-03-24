function [ f ] = Fgrav( R )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
f = zeros (3,1);
global mug;
f(1:3) = -mug*R/norm(R)^3;
end


