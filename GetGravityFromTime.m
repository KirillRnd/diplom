function [f] = GetGravityFromTime(time,r)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
w_earth=7.2921158553e-5;
%time=1000;
theta=pi*(23+26/60+14/3600)/180;
psi=0;
Q0 = my_eul_to_quat(psi, theta, w_earth*time,"ZXZs");
rot_matr=quat2dcm(Q0);
%r=[x,y,z];
r_new=rot_matr*r;
[gx, gy, gz] = gravitysphericalharmonic(r_new');
f=rot_matr^-1*[gx, gy, gz]';
end

