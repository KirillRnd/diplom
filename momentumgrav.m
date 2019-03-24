function [ W2 ] = momentumgrav(R,V,W,Q,t)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

global mug;
Qinv = quatinv(Q');
Rinv = quatrotate(Qinv, R');
global J;

%гравитационный момент
Fg = mug *3 /(sum(Rinv.*Rinv))^(5/2) * cross(Rinv', J*(Rinv'));

%магнитный момент
global magnetmoment;
B=ValueOfMagnetField(R,t);
Binv=quatrotate(Qinv, B')';
Fm=cross(magnetmoment,Binv);

%аэродинамический момент
%Fa=AerodynamicMoment(Q,W,Rinv,V);

P = cross(W , J*W );
%W2=J^(-1)*(Fg+Fm+Fa-P);
W2=J^(-1)*(Fg+Fm-P);
end

