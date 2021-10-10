%% inputs & initializations
clear all; close all; clc;
points= dlmread('../inputs/points.txt');

n= points(1);
points= points( 2:end, :);

xPoints= points(:, 1);
yPoints= points(:, 2);

fig0= figure;
fig0.Color= [0 0.7 0.7];
fig0.MenuBar= 'none';
fig0.Name= 'thePoints';

plot( xPoints, yPoints, 'k.');

axis tight

%% k-means segmentation
[idx,C] = kmeans(points, 2, 'Replicates', 4);

fig1= figure;
fig1.Color= [0 0.7 0.7];
fig1.MenuBar= 'none';
fig1.Name= 'k-means result';

plot(points(idx==1,1),points(idx==1,2),'r.')
hold on
plot(points(idx==2,1),points(idx==2,2),'b.')
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',2)
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
axis tight
hold off

%% mean-shift segmentation
%args= points, sigma, bandW, h, thresh

P= meanShift(points, 2, 2, 2, 0.005);
xP= P(:,1);
yP= P(:,2);

label= zeros(1, n);
c= 1;
thresh= 0.1;
for i=1:n
    if( label(i) == 0 )
        label(i)= c;
        p= P(i,:);
        for j=i+1:n
            q= P(j, :);
            if( label(j) == 0 && eucDis(p,q)<thresh )
                label(j)= c;
            end
        end
        c= c+1;
    end
end

size(unique(label))

fig2= figure;
fig2.Color= [0 0.7 0.7];
fig2.MenuBar= 'none';
fig2.Name= 'MeanShift Result';

plot( xP, yP, 'k.');

axis tight

fig3= figure;
fig3.Color= [0 0.7 0.7];
fig3.MenuBar= 'none';
fig3.Name= 'MeanShift Clustering';

hold on
plot( points(label==1, 1), points(label==1, 2), 'r.');
plot( points(label==2, 1), points(label==2, 2), 'g.');
plot( points(label==3, 1), points(label==3, 2), 'b.');
plot( points(label==4, 1), points(label==4, 2), 'k.');
plot( points(label==5, 1), points(label==5, 2), 'm.');
plot( points(label==6, 1), points(label==6, 2), 'c.');
legend('Cluster 1','Cluster 2', 'Cluster 3', 'Cluster 4',...
       'Cluster 5', 'Cluster 6', 'Location','NW')
title 'Cluster Assignments'
hold off

axis tight

%% new space
rPoints= sqrt( (xPoints.^2+yPoints.^2) );
tethaPoints= atan(yPoints./xPoints);

fig3= figure;
fig3.Color= [0 0.7 0.7];
fig3.MenuBar= 'none';
fig3.Name= 'New Space';

plot( rPoints, tethaPoints, 'k.');

axis tight

%% k-means on new space
[idx,C] = kmeans([rPoints, tethaPoints], 2, 'Replicates', 4);

fig4= figure;
fig4.Color= [0 0.7 0.7];
fig4.MenuBar= 'none';
fig4.Name= 'k-means result';

plot(points(idx==1,1),points(idx==1,2),'r.')
hold on
plot(points(idx==2,1),points(idx==2,2),'b.')
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',2)
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
axis tight
hold off