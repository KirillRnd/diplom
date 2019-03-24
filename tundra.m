
%%    
find_angle=@(x,y)atan2(norm(cross(x,y)), dot(x,y));
%находим k
K = cross(Rnorm(:,1),Rnorm(:,601));
K=K/norm(K);
%находим omega_f и i_f !!!Не забыать потом переделать для более
%произвольных случаев
i_f=find_angle(K,[0 0 1]);
K_p=[K(1) K(2) 0];
omega_f=pi/2-find_angle(K_p,[1 0 0]);
if omega_f<0 
    omega_f=omega_f+2*pi;
end
%проецируем
Rxy=zeros(3,601);
for i=1:N
    
    Rxy(:,i)=Rnorm(:,i)-Rnorm(:,i)'*K*K;
end

Thetha=zeros(1,599);
%сдвинуто на 1 влево
for i=1:N-2
    
    Thetha(1,i)= find_angle(Rxy(:,i),Rxy(:,i+2))/(2*H);
end
%Доварачиваем до плоскости
tmpq_f=my_eul_to_quat(-omega_f, -i_f, 0,"ZXZr");
Atr_f=quat2dcm(tmpq_f);
RXY=Atr_f*Rxy;
Rtruexy=RXY(1:2,:);
%Теперь работаем только с плоскостью
Rxy=zeros(2,599);
Rxy(:,1)=Rtruexy(:,2)*100;
Rlen=norm(Rxy(:,1))^2*abs(Thetha(1,1));
for i=2:N-2
    Rxy(:,i)=(Rlen/abs(Thetha(1,i)))^(1/2)*Rtruexy(:,i+1);
end
%Восстанавливаем эллипс
thetha=zeros(1,601);
for i=1:N
    thetha(1,i)=find_angle([1 0 0],[Rtruexy(1,i) Rtruexy(2,i) 0]);
end
%Исправляем производную
for i=1:N-1
    ft=thetha(1,i+1)-thetha(1,i);
    if ft < 0
        thetha(1,i)=2*pi-thetha(1,i);
    end
end
if thetha(1,N)<thetha(1,N-1)
   thetha(1,N)=2*pi - thetha(1,N); 
end
Rlen=zeros(599);
for i=1:N-2
    Rlen(i)=norm(Rxy(:,i));
end
fun_ell_r = @(e,p,w,th)(p./(1+e.*cos(w+th)));

fun_ell_min=@(x,xdata)(fun_ell_r(x(1),x(2),x(3),xdata));
x0 = [0.0000 100.0000 0];
lb=[0 0 0];
ub=[1.0 10000 2*pi];
x = lsqcurvefit(fun_ell_min,x0,thetha(1:599),Rlen(1:599),lb,ub);
plot(Rxy(1,:),Rxy(2,:));
axis equal;
hold on;
%thetha=(0:0.1:2*pi);
tt_new=thetha;
Rxynorm=fun_ell_min(x,tt_new);
Rxy_new=zeros(2,length(tt_new));
Rxy_new(1,1:length(tt_new))=Rxynorm.*cos(tt_new);
Rxy_new(2,1:length(tt_new))=Rxynorm.*sin(tt_new);
plot(Rxy_new(1,:),Rxy_new(2,:));
hold off;

%фокальный параметр
global mug;
P=((mug./Thetha(1:599).^2).*(1+x(1).*cos(thetha(2:600)+x(3))).^4).^(1/3);
p_f= median(P);
%p_f,omega_f,i_f,K,x(1)=ex,x(3)=w