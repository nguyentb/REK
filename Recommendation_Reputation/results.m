% function re=results(A,U,pr,rem,rep,hyb)
% G=digraph(A')
% %plot(G)
% indeg = indegree(G)
% id=indeg./sum(indeg)
% com=[id pr rem rep hyb];
%{
figure(1)
plot(pr,'-oy')
hold on
plot(rem,'-or')
plot(rep,'-ok')
plot(hyb,'-ob')
legend ('pr','rem','rep','hyb')
figure(2)
bar(com)
legend ('pr','rem','rep','hyb')
%}
%{
figure(2)
bar(C{10})                                %http://www.nature.com/articles/srep16181#f3
legend ('id','pr','hyb')
%}
%% 
%check top 20% nodes
set(groot,'DefaultAxesColorOrder','remove')
set(groot,'DefaultAxesLineStyleOrder','remove')
nd=100;
YY=cell(1,5);
for n = 1:5
    y=cell(1,nd/5);
    for nn=1:nd/5
        x=C{nn}(:,n);
        s=size(x,1);
        m=sort(x(:),'descend');
        tn=s/5;                                %tn number of highest nodes
        t=(x>=m(tn)).*x;
        %t=(t>0)
        y{nn}=sum(t);
    end
    YY{n}=cell2mat(y);
end
n=5:5:nd;
%yy1=cell2mat(YY(1))
plot(n,smooth(YY{1}),'--',n,smooth(YY{2}),'-o',n,smooth(YY{5}),'-d')
legend ('ID','PR','HYB')
xlim([5 100])
% figure(2)
% f=fit(n',YY{1}','poly2')
% plot(f,'--')
% hold on
% f=fit(n',YY{2}','poly2')
% plot(f,'-o')
% hold on
% f=fit(n',YY{5}','poly2')
% plot(f,'-d')

%}
%% 
n=5:5:nd
t=100
ft=exp(n/t);
plot(n,ft)
%% 
%%set(groot,'DefaultAxesColorOrder','remove')
set(0,'defaultlinelinewidth',1) 
%%%%'DefaultAxesColorOrder',[0 0 0],...
set(groot,'DefaultAxesLineStyleOrder','--|-d|:|-.') 
nd=100;
CC=cell(1,nd/5);
for n = 1:nd/5
    x=C{n}(:,1);
    y=C{n}(:,2);
    z=C{n}(:,5);
    [r1,p1] = corr(x,y,'type','Kendall');
    [r2,p2] = corr(x,z,'type','Kendall');
    CC{n}=[r1 r2]'
end
ck=cell2mat(CC)
m=5:5:nd;
cm=cumsum(m);
plot(m,smooth(ft.*ck(1,:)),'--.',m,smooth(ft.*ck(2,:)),'-s')
%plot(smooth(ck(1,:)),cm,smooth(ck(2,:)),cm)
legend('PR','HYB')
title('Kendall tau distance')
axis([10 100 0 3])
%% 
x=C{20}(:,5)
F=fitmethis(x')
[parmhat,parmci] = gevfit(x')
[M,V] = gevstat(parmhat(1),parmhat(2),parmhat(3))  %%k,sigma,mu
%% 
%Good sites in PR vs Hyb
set(groot,'DefaultAxesColorOrder','remove')
set(groot,'DefaultAxesLineStyleOrder','remove')
thr=0.01;
nd=100;
YY=cell(1,5);
for n = 1:5
    y=cell(1,nd/5);
    for nn=1:nd/5
        x=C{nn}(:,n);
        t=(x>=thr);  %good nodes
        y{nn}=sum(t);
    end
    YY{n}=cell2mat(y);
end
n=5:5:nd;
PR=YY{2}./n*100;
HY=YY{5}./n*100;
bp=[PR' HY']
bar(n,bp)
title ('% of Good nodes')
ylabel('% nodes')
legend ('PR','HYB')
xlim([0 100])

%% 
%Bad sites in PR vs Hyb
set(groot,'DefaultAxesColorOrder','remove')
set(groot,'DefaultAxesLineStyleOrder','remove')
thb=0.009;
nd=100;
YY=cell(1,5);
for n = 1:5
    y=cell(1,nd/5);
    for nn=1:nd/5
        x=C{nn}(:,n);
        t=(x<=thb);  %bad nodes
        y{nn}=sum(t);
    end
    YY{n}=cell2mat(y);
end
n=5:5:nd;
PR=YY{2}./n*100;
HY=YY{5}./n*100;
bp=[PR' HY']
bar(n,bp)
title ('% of Bad node detection')
ylabel('% nodes')
legend ('PR','HYB')
xlim([0 100])
