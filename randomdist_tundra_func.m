function [outr,outv] = randomdist_tundra_func(Rnorm,Rnorm_tmp,r0,V0,sdr0,sdv0,h,iter)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%%������� ��������� ����� � �������
%sdr0=1e+03;
tmpq=my_eul_to_quat(rand*2*pi, rand*2*pi, rand*2*pi, "ZXZs");
rot_matr=quat2dcm(tmpq);
dr0=rot_matr*[1 0 0]'*sdr0;

%sdv0=1e+01;
tmpq=my_eul_to_quat(rand*2*pi, rand*2*pi, rand*2*pi, "ZXZs");
rot_matr=quat2dcm(tmpq);
dV0=rot_matr*[1 0 0]'*sdv0;

V02=V0+dV0;
r02=r0+dr0;


%h=10;
%iter=1000;

dF=getDeriv(h,iter,r02,V02);
d=Rnorm(:,2:iter+1)-normR4hiter(h,iter, r02,V02);

Aa=dF'*dF;
Bb=dF'*d(:);
v=Aa\Bb;
rfound=r02+v(1:3);
Vfound=V02+v(4:6);
Graph=zeros(50,1);

Graph2=zeros(50,1);
Graph3=zeros(50,1);
i = 0;
while i<3
    r02=rfound;
    V02=Vfound;
    
    dF=getDeriv(h,iter,r02,V02);
    d=Rnorm(:,2:iter+1)-normR4hiter(h,iter, r02,V02);

    Aa=dF'*dF;
    Bb=dF'*d(:);
    v=Aa\Bb;
    
    rfound=r02+v(1:3);
    Vfound=V02+v(4:6);
    
    i=i+1;
    Graph(i)=norm(rfound-r0);
    Graph2(i)=norm(Vfound-V0);
    local_deriv=Rnorm_tmp(:,2:iter+1)-normR4hiter(h,iter, r02,V02);
    
    for j=1:length(local_deriv)
        Graph3(i)=Graph3(i)+norm(local_deriv(1:3,j));
    end
end
outr=norm(rfound-r0);
%norm(v(1:3))

outv=norm(Vfound-V0);
%norm(v(4:6))
%Vfound-V0
end

