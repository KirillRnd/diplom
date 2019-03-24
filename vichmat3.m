clear
clc

x0=1;
x1=2;
y0=4;
e=10^-1;


h=0.1;

f=1;%просто флаг
ch=1;%счетчик итераций
d=1;
iteration=ceil((x1-x0)/h);
while d>e

    %уточняем h
    h=(x1-x0)/iteration;
    X = zeros(1,iteration+1);
    Y = zeros(1,iteration+1);
    X(1) = x0;
    Y(1) = y0;

    %1-3 радиус вектор/ 4-6 скорость/ 7-9 угловая скорость/10-13 кватернион/
    %/время i+1/(2..3)/
    for i = 1:1:iteration % [dot_R; dot_V]
        k1=EilerFunction(X(i),Y(i));

        k2=EilerFunction(X(i)+h/2,Y(i)+(h/2)*k1);

        X(i+1)=X(i)+h;
        Y(i+1)=Y(i)+h*k2;
    end
    if f==1
        f=0;
        iteration=iteration*2;
        Ypred=Y;
        d=1;
    else 
        ch=ch+1;
        Y(iteration+1)
        d=max(abs(Y(1:2:iteration+1)-Ypred(1:1:iteration/2+1)))/(2^2-1);
        iteration=iteration*2;
        Ypred=Y;
    end
end


plot(X,Ypred)



