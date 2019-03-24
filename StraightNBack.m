function [ U ] = StraightNBack( a,b,c,d )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
LL=length(a);
U(1,1:LL)=0;
aa(1,1:LL)=0;
aa(1)=-a(1)/b(1);

bb(1,1:LL)=0;
bb(1)=d(1)/b(1);

for l = 2:LL-1
   aa(l)=-a(l)/(b(l)+c(l)*aa(l-1));
   bb(l)=(d(l)-c(l)*bb(l-1))/(b(l)+c(l)*aa(l-1));
   
end
U(LL)=(d(LL)-c(LL)*bb(LL-1))/(b(LL)-c(LL)*aa(LL-1));

for l = LL-1:-1:2
   
   U(l)=aa(l)*U(l+1)+bb(l);
   
end
  U(1)=aa(1)*U(2)+bb(1);
end

