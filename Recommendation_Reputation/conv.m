%     load('mat50.mat')
%     load('Umat50.mat')
%     A=smat;
%     U=U;
    n=100;
    A=stomat(n);
    U=invstomat(A);
    err= 1;
    tol=1e-5;
    N=size(A,1);
t=invrank(U,err,tol);
%initial guess for r
R = t;
a=0.8;
% keep iterating while the stopping criterion is not met
n=1;
nn=cell(1,20);
ee=cell(1,20);
while(err>tol)
    % premultiply the current page rank vector
    % with the transition matrix
    S=a*A*R+(1-a)*t;
    % use an absolute stopping residual
    err=norm(S-R);
    % update the page rank vector
    R=S;
    nn{n}=n
    ee{n}=err
    n=n+1;
end
xx=cell2mat(nn)
yy=cell2mat(ee)
plot(xx,smooth(yy))
xlim([1 10])
xlabel('Iterations')
ylabel('Error')
title('Convergence of the Algorithm(100 nodes)')