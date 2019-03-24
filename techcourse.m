%Тело основной программы и входных данных
%clear; clc; % Очистка памяти и экрана
h = 10; % Шаг интегрирования секунды
t_fin = 600; % Конечное время интегрирования
%константы
global mug;
mug=398600.4415*(1000^3)+80/9*10^4;
%кеплеровы параметры
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
%r0 = [46000000 10000 0]; % Начальное значение функции
%V0 = [2000 7000 200]; % Начальное значение производной функции
iter = 6005;
w0=[0 0.001 0];

% углы эйлера поворота тела
psi = pi/2;
theta = pi/6;
phi = pi/4;
Q0 = my_eul_to_quat(psi, theta, phi,"ZXZs");
%магнитный момент тела
global magnetmoment;
Mi = 3.5*10^(3-10);
%взято из Белецкого Движение искусственного спутника относительно центра масс
magnetmoment=Mi*[1 0 0]';
global t0;
t0=0;
%Тензор инерции
global J;
A = 10; B = 8; C = 15;
J = [A 0 0; 0 B 0; 0 0 C];
I = [[1 0 0]'  [0 1 0]'  [0 0 1]'];
%параметры для аэродинамики
global S;   %площадь
S=1;      %метры квадратные
global n;   %нормаль к площадке ССК
global Rcm; %координаты центра площадки ССК
Rcm=[0.02 0 0]';
n=[1 0 0]';
global alpha;
global eps;
alpha=0.1;
eps=0.1;
global Ratm;
global roatm;%плотность атмосфеы на заданной высоте
global Tatm;
Ratm=400000+6371000;   %м
Tatm=995.9;   %К
roatm=2.79396E-12; %кг/м^3

global AtmConst;
MolarMass=28.98*10^(-3);%кг/моль
Runiv=8.3144598;
AtmConst=MolarMass*mug/(Tatm*Runiv);

%расчет
%[R, V, W , Q] = rungeK(h,iter, r0, V0, Q0,w0); % Метод Рунге — Кутты
[R, V] = rungeKShort(h,iter, r0, V0);

%Запуск графика через techgraph.m
