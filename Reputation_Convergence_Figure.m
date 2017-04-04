% Randomly generate Experience matrix exp_mat(nxn)
% exp_mat(i,j) = 0 if no experience from i to j
% exp_mat(i,j) = x if there is experience from i to j with value x
% 0 < x < 1 
n = 100;
exp_mat = sprand(n, n, 0.03);
for i=1:n
    exp_mat(i, i) = 0;    % no experience of one entity to itself
end

% Exp_mat matrix will be extracted to attain Exp_mat_pos and Exp_mat_neg
% Ext_mat(i,j) >= threshold => Ext_mat_pos
% 0< Ext_mat(i,j) < threshold => Ext_mat_neg
% Let define threshold

threshold = 0.5;
exp_mat_pos = zeros(n,n);
exp_mat_neg = zeros(n,n);

for i=1:n
    for j=1:n
        if (exp_mat(i,j) >= threshold)
            exp_mat_pos(i,j) = exp_mat(i,j);
        elseif (0 < exp_mat(i,j))&&(exp_mat(i,j) < threshold)
            exp_mat_neg(i,j) = 1 - exp_mat(i,j);
        end
    end
end

% Generate a transition matrix M
% M(i, j) = 0 if there is no Experience from j to i
% M(i, j) = exp(j, i)/C(j) where exp(j, i) is experience from j to i;
% and C(j) is total experience of node j

c_pos = zeros(1, n);
c_neg = zeros(1, n);
for i=1:n
    for j=1:n
        c_pos(1, i) = c_pos(1, i) + exp_mat_pos(i, j);
        c_neg(1, i) = c_neg(1, i) + exp_mat_neg(i, j);
    end
end

damping = 0.85;
%alpha = (1-damping)/n;
alpha = 1 - damping;
%A as the transition matrix
A_pos = zeros(n, n);
A_neg = zeros(n, n);
for i=1:n
    for j=1:n
        if exp_mat_pos(j, i) > 0
            A_pos(i, j) = exp_mat_pos(j, i)/c_pos(1, j);        
        elseif exp_mat_neg(j, i) > 0
            A_neg(i, j) = exp_mat_neg(j,i)/c_neg(1, j);
        end
    end
end

err = 1;
tol = 1e-3;
rep_pos = ones(n, 1)/n; % initial ranking vector
rep_neg = ones(n, 1)/n; % initial ranking vector
I = ones(n, 1);
iter = 1;
nn=cell(1,50);
ee=cell(1,50);
while(err>tol)    
    S_pos = damping*A_pos*rep_pos + alpha*I;
    S_neg = damping*A_neg*rep_neg + alpha*I;
    err = norm((S_pos-rep_pos) + norm(S_neg-rep_neg));
    rep_pos = S_pos;
    rep_neg = S_neg;
    str=sprintf('Iteration: %d -- Error: %d: \n', iter, err);
    disp(str);
    
    nn{iter}=iter;
    ee{iter}=err;
    iter = iter + 1;
end

rep1 = rep_pos - rep_neg;
rep = rep1;
rep(rep < 0) = 0;

[~,~,rank_vector] = unique(rep);
jx = 1;
highlight_vector = zeros();
for i=1:n
    if (rank_vector(i) >= n/2)
        highlight_vector(jx) = i;
        jx = jx + 1;
    end
end

%GX = digraph(exp_mat);
%plot(GX, 'Layout','layered', 'EdgeLabel',GX.Edges.Weight, 'NodeLabel', rank_vector);
%GX.Nodes.NodeColors = rank_vector;
%p = plot(GX, 'Layout','layered', 'NodeLabel', rank_vector,'EdgeColor','black');
%p.NodeCData = GX.Nodes.NodeColors;
%colorbar;
%p.MarkerSize = 15;
%p.NodeColor = 'r';
%highlight(p, highlight_vector, 'NodeColor','g')
%view(2);

xx = cell2mat(nn);
yy = cell2mat(ee);
%plot(xx, yy, '-.*', 'DisplayName','N = 100');
plot(xx, yy, '-.o', 'LineWidth',1);
hold on;
%plot(xx400,yy400, '-.+', 'DisplayName','N = 400');
%plot(xx800,yy800, '-.o', 'DisplayName','N = 800');
plot(xx400,yy400, '-.+', 'LineWidth',1);
plot(xx800,yy800, '-.*', 'LineWidth',1);

xlim([1 50])
xlabel('Iterations', 'FontSize',12);
ylabel('Error', 'FontSize',12);
title('Convergence of the Algorithm', 'FontSize',13);
lgt = legend({'N=100','N=400', 'N=800'},'FontSize',13)
title(lgt, 'Size of the Network');
legend('show');

%bins = conncomp(GX);
%[S,C] = graphconncomp(r1);