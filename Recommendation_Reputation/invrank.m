function t=invrank(U,err,tol)
% initial guess for IR
N=size(U,1);
IR = 1/N * ones(N,1);
% keep iterating while the stopping criterion is not met
while(err>tol)
    % premultiply the current inverse page rank vector
    % with the inverse transition matrix
    IS = U*IR;
    % use an absolute stopping residual
    err=norm(IS-IR);
    % update the inverse page rank vector
    IR=IS;
end
% normalize the page rank to have unit sum
x = IR/sum(IR);

%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%  Selecting trustworthy nodes
m=sort(x(:),'descend');
tn=N/5;                                %tn number of highest nodes
t=(x>=m(tn)).*x;
t=(t>0);
%t(1,:)=0;  %make the node malicious 
t=(t>0)./tn;
%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%
