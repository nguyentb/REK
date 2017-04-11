function R=recrank2(err,tol,N,A,U)
t=invrank(U,err,tol);
%initial guess for r
R = t;
a=0.8;
% keep iterating while the stopping criterion is not met
while(err>tol)
    % premultiply the current page rank vector
    % with the transition matrix
    S=a*A*R+(1-a)*t;
    % use an absolute stopping residual
    err=norm(S-R);
    % update the page rank vector
    R=S;
end
% normalize the page rank to have unit sum
%R = R/sum(R);


