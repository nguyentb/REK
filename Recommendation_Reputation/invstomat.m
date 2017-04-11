function ismat=invstomat(AA)
% load('mat10.mat')
% A=smat
A=AA;
G=digraph(A');
% subplot(2,1,1);
% plot(G)
% title('G');
[sOut,tOut] = findedge(G);
s=tOut;
t=sOut;
I = digraph(s,t);
% subplot(2,1,2);
% plot(I);
% title('I');
Ua=adjacency(I);
Ua=Ua';
U=full(Ua);
div=repmat(sum(U,1),size(U,1),1);
U=U./div;
ismat=U;
sum(sum(A))
sum(sum(U))