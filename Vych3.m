clc;
clear;
dif=1;
acc=0.0001;
L=10;
while dif>acc
    f=@(x)cos(2*pi*x);

    q=@(x)1;
    k=@(x)1;

    F=f;

    h=1/L;
    LL=L+1;
    x=(0:h:1);

    %% нач параметры

    a(1,1:LL)=0;
    a(1,2:LL-1)=k(x(1,2:LL-1));

    b(1,1:LL)=0;
    b(1)=1;
    b(LL)=1;
    b(1,2:LL-1)=-2*k(x(1,2:LL-1))-q(x(1,2:LL-1))*h^2;

    c(1,1:LL)=0;
    c(1,2:LL-1)=k(x(1,2:LL-1));


    %% блок для ню
    d(1,1:LL)=-h^2*f(x(1:LL));
    d(1,1)=0;
    d(1,LL)=0;

    nu=StraightNBack(a,b,c,d);
    %% Блок для мю
    d(1)=1;
    d(2:LL-1)=0;
    d(LL)=1;
    mu=StraightNBack(a,b,c,d);

    %% U0
    U(1,1:LL)=0;
    U(1)=(k(0)*(nu(2)+nu(LL-1))+f(0)*h^2)/(2*k(0)+q(0)*h^2-k(0)*(mu(2)+mu(LL-1)));
    U(2:LL)=nu(2:LL)+U(1)*mu(2:LL);
    UF=F(x)/(4*pi^2*k(0)+q(0));

    dif=max(abs(U-UF));
    L=L*2;
end
%% Переменные коэффициенты
k=@(x)exp(sin(2*pi*x));
q=@(x)1;
f=@(x)exp(cos(2*pi*x));


a(1,2:LL-1)=k(x(1,2:LL-1)+h/2);
b(1,2:LL-1)=-(k(x(1,2:LL-1)+h/2)+k(x(1,2:LL-1)-h/2)+q(x(1,2:LL-1))*h^2);
c(1,2:LL-1)=k(x(1,2:LL-1)-h/2);
d(1,2:LL-1)=-h^2*f(x(1,2:LL-1));

a(1)=0;
a(LL)=0;

b(1)=1;
b(LL)=1;

c(1)=0;
c(LL)=0;

d(1)=0;
d(LL)=0;

nu=StraightNBack(a,b,c,d);

d(1)=1;
d(2:LL-1)=0;
d(LL)=1;
mu=StraightNBack(a,b,c,d);
%% вычисление для переменных коэфф
U(1,1:LL)=0;
U(1)=(k(h/2)*nu(2)+k(x(LL)-h/2)*nu(LL-1)+f(0)*h^2)/(k(h/2)+k(x(LL)-h/2)+q(0)*h^2-k(h/2)*mu(2)+k(x(LL)-h/2)*mu(LL-1));
U(2:LL)=nu(2:LL)+U(1)*mu(2:LL);
plot(x,U)