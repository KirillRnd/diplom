 clear;
clc;
g0 = 5/3;
r0 = 10^-5;
u0=0;
p0=3.848*10^3;
g3=7/5;
c3=2.53248*10^4;
u3=0;
p3=3.04*10^9;

r3=g3*p3/(c3^2);



a0=(g0+1)/(g0-1);
n=2*g3/(g3-1);
mu=(u3-u0)*sqrt((g0-1)*r0/(2*p0));
nu=2/(g3-1)*sqrt(g3*(g0-1)*p3*r0/(2*p0-r3));
X=p3/p0;
a(1:15)=0;



a(fix(2*n+1))=X.^2;
a(fix(n+2)+1)=-a0*nu.^2*X;
a(fix(n+1)+1)=2*a0*nu*(mu + nu)*X;
a(fix(n)+1)=-(2+(mu+nu).^2*a0)*X;
a(3)=-nu.^2;
a(2)=2*nu*(mu+nu);
a(1)=1-(mu+nu).^2;

a'
A=max(abs(a(1:14)));
B=max(abs(a(2:15)));
L1=abs(a(1))/(abs(a(1))+B)
L2=1+ A/abs(a(15))

N=0;
j=sign(a(1));
for i = 2:15
    if (sign(a(i))~= j) && (a(i)~=0)
        j=sign(a(i));
        N=N+1;
    end
end

M=1000;
y = linspace(L1,L2,M);
f=polyval(a(15:-1:1),y);
%перемена знака функции 
b(1)=0;
N1=0;
j=sign(f(1));
for i = 2:1000
    if (sign(f(i))~= j) && (f(i)~=0)
        j=sign(f(i));
        N1=N1+1;
        b(N1)=i;
    end
end
%верхние точки интервалов
z=zeros(1000,length(y(b)));
z(1,:)=y(b);
a1=a(2:15).*(2:15);
a2=a1(2:14).*(2:14);
M2=max(polyval(a2(13:-1:1),[z;y(b-1)]));
m1=min(polyval(a1(14:-1:1),[z;y(b-1)]));
%схождение к корням
dx=L2-L1;
j=1;
while abs(dx*M2/(2*m1)) > 0.000001
    z(j+1,:)=z(j,:)-(polyval(a(15:-1:1),z(j,:)))./(polyval(a1(14:-1:1),z(j,:)));
    dx=max(z(j+1,:)-z(j,:));
    j=j+1;
end

Z=z(j-1,:)

p1=(Z.^n).*p3;
c2=c3*(p1/p3).^(1/n);
u1=u3+2*c3/(g3-1)-2*c2/(g3-1);
d0=((p1-p0)/r0+u0*u1)./(u1-u0);
D0=d0