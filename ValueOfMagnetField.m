function [ B ] = ValueOfMagnetField( R,t )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global t0; %�������
%���������� ������� ����������
mue=7.82*10^(6+3*3);
k0=[-1 0 0];

%���� �������� �����
psi = (t+t0)*2*pi/(24*60*60);
theta = (11.7/180)*pi;
phi = 0;
Q0 = angle2quat(psi, theta, phi, 'ZXZ');
k = quatrotate(Q0, k0)';
%���������� ���� � �����
B=(mue/norm(R)^5)*(k*norm(R)^2-3*(k*R')*R);
end

