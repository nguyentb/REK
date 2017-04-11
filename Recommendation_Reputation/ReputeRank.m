clc
clear
for n = 5:5:100 
	if n<51
        load(['mat' num2str(n) '.mat'])
        load(['Umat' num2str(n) '.mat'])
        A=smat;
        U=U;
    else
        A=stomat(n);
        U=invstomat(A);
    end
% load('mat10.mat')
% load('Umat10.mat')
   
%A=[0 0.5 0 0 0; 1/3 0 0 0 1; 1/3 0.5 0 0 0; 1/3 0 1 0 0; 0 0 0 1 0];   %Transition matrix
%U=[0 0.5 0.5 0.5 0; 1 0 0.5 0 0; 0 0 0 0.5 0; 0 0 0 0 1; 0 0.5 0 0 0];   %Inverse Transition matrix

%A=[0 0.5 0 0 0; 0 0 0 0 1; 1/2 0.5 0 0 0; 1/2 0 1 0 0; 0 0 0 1 0];   %Transition matrix
%U=[0 0 0.5 0.5 0; 1 0 0.5 0 0; 0 0 0 0.5 0; 0 0 0 0 1; 0 1 0 0 0];   %Inverse Transition matrix

    % stopping residual
    err= 1;
    tol=1e-2;
    N=size(A,1);

    %invrank(U,err,tol)
    PR=recrank1(err,tol,N,A);
    REC=recrank2(err,tol,N,A,U);
    REP=reprank(err,tol,N,A,U);

    g=0.8;
    HYB=g*REC+(1-g)*REP;

    G=digraph(A');
    %plot(G)
    indeg = indegree(G);
    ID=indeg./sum(indeg);

    C{n/5}=[ID PR REC REP HYB];
end
%results(A,U,PR,REC,REP,HYB)

