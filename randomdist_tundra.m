Rnew=R(:,1:6001);%������� �����

N = 6001;
Rnorm_tmp=zeros(3,N);
for i=1:N
    Rnorm_tmp(:,i)=Rnew(:,i)/norm(Rnew(:,i));
end
grad_0=1;
SS=grad_0*2*pi/360;
Rnorm=zeros(3,N);
for i=1:N-1
    Rnorm(:,i)=random_deviation(Rnorm_tmp(:,i)',cross(Rnorm_tmp(:,i),Rnorm_tmp(:,i+1)),SS);
end

    Rnorm(:,N)=random_deviation(Rnorm_tmp(:,N)',cross(Rnorm_tmp(:,N-1),Rnorm_tmp(:,N)),SS);
%%������� ��������� ����� � �������
sdr0=1e+03;
tmpq=my_eul_to_quat(rand*2*pi, rand*2*pi, rand*2*pi, "ZXZs");
rot_matr=quat2dcm(tmpq);
dr0=rot_matr*[1 0 0]'*sdr0;

sdv0=1e+01;
tmpq=my_eul_to_quat(rand*2*pi, rand*2*pi, rand*2*pi, "ZXZs");
rot_matr=quat2dcm(tmpq);
dV0=rot_matr*[1 0 0]'*sdv0;

V02=V0+dV0;
r02=r0+dr0;


h=10;
iter=1000;

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
Graph4=zeros(50,1);
i = 0;
while i<10
    r02=rfound;
    V02=Vfound;
    
    dF=getDeriv(h,iter,r02,V02);
    d=Rnorm(:,2:iter+1)-normR4hiter(h,iter, r02,V02);

    Aa=dF'*dF;
    Bb=dF'*d(:);
    v=Aa\Bb;
    
    rfound=r02+v(1:3);
    Vfound=V02+v(4:6);
    
    i=i+1
    Graph(i)=norm(rfound-r0);
    Graph2(i)=norm(Vfound-V0);
    local_deriv=Rnorm_tmp(:,2:iter+1)-normR4hiter(h,iter, r02,V02);
    
    for j=1:length(local_deriv)
        Graph3(i)=Graph3(i)+norm(local_deriv(1:3,j));
    end
end
norm(rfound-r0)
%norm(v(1:3))

norm(Vfound-V0)
%norm(v(4:6))
%Vfound-V0