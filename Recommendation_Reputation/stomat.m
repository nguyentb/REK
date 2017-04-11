function smat=stomat(n)
%n=55;
%x=randi(2,n)-1
%x=rand([0 1], n, n)>0.8
% flag=0/0
% while isnan(flag)
    x=randsrc(n,n,[0 1;0.8 0.2]);
    x(all(x==0,2),:)=[];
    x(:,all(x==0,1))=[];
    [a,b]=size(x);
    m=min(a,b);
    x=x(1:m,1:m);
    x=x-diag(diag(x));
    nrm=sum(x,1);
    %flag=sum(nrm)
%end
div=repmat(nrm,size(x,1),1);
smat=x./div;
size(smat);

% G=digraph(smat);
% plot(G)