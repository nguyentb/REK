function R=recrank1(err,tol,N,A)
%initial guess for r
R = 1/N*ones(N,1);
% keep iterating while the stopping criterion is not met
while(err>tol)
    % premultiply the current page rank vector
    % with the transition matrix
    S = A*R;
    % use an absolute stopping residual
    err=norm(S-R);
    % update the page rank vector
    R=S;
end
% normalize the page rank to have unit sum
%R = R/sum(R);
