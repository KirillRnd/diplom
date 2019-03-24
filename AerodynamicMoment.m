function Fa = AerodynamicMoment( Q,W,Rinv,V )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global n;
global Rcm;
global S;

global alpha;
global eps;

global roatm;
global Ratm;

global AtmConst;%MolarMass*mug/(R*T)
%��������� �����(���������)

ro=roatm*exp(AtmConst*(Ratm-norm(Rinv))/(norm(Rinv))^2);
%��������� V � ���
Qinv = quatinv(Q');
Vssk=quatrotate(Qinv, V')';
%��������������� ���������
I1=S*cross(W,Rcm);
I2=(pi*(S^4)/4)*cross(n,W);
I3=(pi*(S^4)/4)*(W+n*(W'*n));
%�������� ���������
tmp=(1-eps)*(Vssk+n*alpha)+4*eps*n*(Vssk'*n);

I4=tmp*(I1'*n)-ro*(1-eps)*(Vssk'*n)*I1;

I5=-ro*cross(I2,tmp)-ro*(1-eps)*(Vssk'*n)*I3;

F1=-ro*(Vssk'*n)*((1-eps)*Vssk+2*eps*n*(Vssk'*n)+(1-eps)*alpha*n)*S;

Fa=I4+I5+cross(Rcm,F1);
end

