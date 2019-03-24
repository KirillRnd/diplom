%���� �������� ��������� � ������� ������
%clear; clc; % ������� ������ � ������
h = 10; % ��� �������������� �������
t_fin = 600; % �������� ����� ��������������
%���������
global mug;
mug=398600.4415*(1000^3)+80/9*10^4;
%��������� ���������
ex=0.7;
a=42164000/2;
i=63.4/360*2*pi;
w = 270/360*2*pi;
omega=270/360*2*pi;

E=pi/3;
%%%%%
%ex=0.0;
%a=42164000;
%i=0;
%omega=0;
%w=0;
b = a*sqrt(1-ex^2);
r00=[a*(cos(E)-ex) b*sin(E) 0]';
tmpq=my_eul_to_quat(omega, i, w,"ZXZs");

Atr=quat2dcm(tmpq);
r0=Atr*r00;

sinTh=b*sin(E)/norm(r0);
p=a*(1-ex^2);
cInt=sqrt(mug * p);

k=Atr*[0 0 1]';
rn=r0/norm(r0);

Vr=sqrt(mug/p)*ex*sinTh*rn;
Vn=cInt/norm(r0)*cross(k,rn);
V0=Vn+Vr;
%%
%r0 = [46000000 10000 0]; % ��������� �������� �������
%V0 = [2000 7000 200]; % ��������� �������� ����������� �������
iter = 6005;
w0=[0 0.001 0];

% ���� ������ �������� ����
psi = pi/2;
theta = pi/6;
phi = pi/4;
Q0 = my_eul_to_quat(psi, theta, phi,"ZXZs");
%��������� ������ ����
global magnetmoment;
Mi = 3.5*10^(3-10);
%����� �� ��������� �������� �������������� �������� ������������ ������ ����
magnetmoment=Mi*[1 0 0]';
global t0;
t0=0;
%������ �������
global J;
A = 10; B = 8; C = 15;
J = [A 0 0; 0 B 0; 0 0 C];
I = [[1 0 0]'  [0 1 0]'  [0 0 1]'];
%��������� ��� ������������
global S;   %�������
S=1;      %����� ����������
global n;   %������� � �������� ���
global Rcm; %���������� ������ �������� ���
Rcm=[0.02 0 0]';
n=[1 0 0]';
global alpha;
global eps;
alpha=0.1;
eps=0.1;
global Ratm;
global roatm;%��������� �������� �� �������� ������
global Tatm;
Ratm=400000+6371000;   %�
Tatm=995.9;   %�
roatm=2.79396E-12; %��/�^3

global AtmConst;
MolarMass=28.98*10^(-3);%��/����
Runiv=8.3144598;
AtmConst=MolarMass*mug/(Tatm*Runiv);

%������
%[R, V, W , Q] = rungeK(h,iter, r0, V0, Q0,w0); % ����� ����� � �����
[R, V] = rungeKShort(h,iter, r0, V0);

%������ ������� ����� techgraph.m
