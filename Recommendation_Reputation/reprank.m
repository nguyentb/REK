function Rf=reprank(err,tol,N,A,U)
tr=invrank(U,err,tol);
Rf=zeros(N,1);
beta=0.8;
% keep iterating while the stopping criterion is not met
for n=2:4
    err=1;
    T=A^n;
    %initial guess for r
    R = tr;
    while(err>tol)
        % premultiply the current page rank vector
        % with the transition matrix
        S= beta*T^n*R+(1-beta)*tr;
        % use an absolute stopping residual
        err=norm(S-R);
        % update the page rank vector
        R=S;
    end
    Rf(:,n-1)=R;
end
Rf=0.8*Rf(:,1)+0.16*Rf(:,2)+0.04*Rf(:,3);

    

% normalize the page rank to have unit sum
%R = R/sum(R);
