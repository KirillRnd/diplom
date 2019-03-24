function [dFdq] = getDeriv(h,iter,r0,v0)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
dFdq=zeros(3*(iter),6);
dr0=1e+04;
dV0=1e+01;
%[d0,R0,V0] = normR4hiter(h,iter, r0,v0);

[d1] = normR4hiter(h,iter, r0+[dr0 0 0]',v0);
[d2] = normR4hiter(h,iter, r0+[0 dr0 0]',v0);
[d3] = normR4hiter(h,iter, r0+[0 0 dr0]',v0);
[d10] = normR4hiter(h,iter, r0-[dr0 0 0]',v0);
[d20] = normR4hiter(h,iter, r0-[0 dr0 0]',v0);
[d30] = normR4hiter(h,iter, r0-[0 0 dr0]',v0);

dFd1=(d1-d10)/(2*dr0);
dFd2=(d2-d20)/(2*dr0);
dFd3=(d3-d30)/(2*dr0);

[d4] = normR4hiter(h,iter, r0,v0+[dV0 0 0]');
[d5] = normR4hiter(h,iter, r0,v0+[0 dV0 0]');
[d6] = normR4hiter(h,iter, r0,v0+[0 0 dV0]');
[d40] = normR4hiter(h,iter, r0,v0-[dV0 0 0]');
[d50] = normR4hiter(h,iter, r0,v0-[0 dV0 0]');
[d60] = normR4hiter(h,iter, r0,v0-[0 0 dV0]');

dFd4=(d4-d40)/(2*dV0);
dFd5=(d5-d50)/(2*dV0);
dFd6=(d6-d60)/(2*dV0);

dFdq(:,1)=dFd1(:);
dFdq(:,2)=dFd2(:);
dFdq(:,3)=dFd3(:);
dFdq(:,4)=dFd4(:);
dFdq(:,5)=dFd5(:);
dFdq(:,6)=dFd6(:);

end

