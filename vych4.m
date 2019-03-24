clc;
clear;
LL=100;
NN=400;
tau=1/NN;
h=1/LL;
N=NN+1;
L=LL+1;
psi=@(x)(exp(2*x)+1/2*x.^2);
psi1=@(x)(2*exp(2*x)+x);
psi2=@(x)(4*exp(2*x)+1);
a=@(x)(exp(x));
a1=a;
b=@(x)x;
b1=@(x)1;
phi=@(x)(x-1).^2;
U(1:N,1:L)=0;
x=(0:h:1);
t=(0:tau:1);
%% граничные условия
U(1:N,1)=psi(t);
U(1,1:L)=phi(x);
Ux=1./a(t).*(b(t)-psi1(t));
Uxx=1./(a(t).^2).*(psi2(t)+a1(t)./a(t).*(b(t)-psi1(t))-b1(t));
U(1:N,2)=U(1:N,1)+h*Ux'+Uxx'*(h^2)/2;
%% расчет
for l=3:L
    for n=1:N-1
        U(n+1,l)=U(n,l)+tau/(2*h)*(1+tau/2)*exp(t(n))*(-U(n,l-2)+4*U(n,l-1)-3*U(n,l))...
            +tau^2/(2*h^2)*exp(2*t(n))*(U(n,l-2)-2*U(n,l-1)+U(n,l))+tau*(t(n)+tau/2);
    end
end
%% теория
Z(1:N,1:L)=0;
UF=@(t,x)(t.^2/2+(x-exp(t)).^2);
for l=1:L
    for n=1:N 
        Z(n,l)=UF(t(n),x(l));
    end
end
%% вывод
v=1:100;
surf(t(v),x(v),Z(v,v))
figure
surf(t(v),x(v),U(v,v))
dif=max(max(abs(U(v,v)-Z(v,v))));