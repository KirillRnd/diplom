function [ f ] =quatRunge( Q, W )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
We=[0;W];
% W2=quatmultiply(Q',We');
% Wi=quatmultiply(W2,quatconj(Q'));
f=(1/2*quatmultiply(Q',We'))';

end

