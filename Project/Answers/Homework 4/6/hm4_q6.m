%% inputs & initializations
clear all; close all; clc;
points= dlmread('../inputs/points.txt');

n= points(1);
points= points( 2:end, :);

r= 1000;%TODO
sigma= 0.5;%TODO

%% Creating the graph
W= zeros(n);
for i=1:n
    p= points(i,:);
    for j=i+1:n
        q= points(j, :);
        dis= eucDis(p, q);
        if( dis < r )
            W(i,j)= exp( -( dis^2/(2*sigma^2) ) );
            W(j,i)= W(i,j);
        end
    end
end
figure('name', 'W', 'MenuBar', 'none'), imagesc(W);
%% NCut Segmentation
d= sum(W);
D= diag(d);
invSqrtD = diag(1./sqrt(d));
M = invSqrtD*(D-W)*invSqrtD;
figure('name', 'invSqrtD*(D-W)*invSqrtD', 'MenuBar', 'none'), imagesc(M);

[EVecs, EVals]= eigs(M, 2, 'sm');

secondEVec= EVecs(:, 2);
figure('name', 'Vector of Second Smalest Eigen Value', 'MenuBar', 'none'), imagesc(secondEVec);
%median2ndEV= median(secondEVec);
%delim= median2ndEV;
delim= 0;
A= secondEVec <= delim;
B= secondEVec > delim;

%% show result
fig0= figure;
fig0.Color= [0 0.7 0.7];
fig0.MenuBar= 'none';
fig0.Name= 'NCut Segmentation';

plot(points(A,1),points(A,2),'r.')
hold on
plot(points(B,1),points(B,2),'b.')
legend('Label 1','Label 2',...
       'Location','NW')
axis tight
hold off