%% inputs & initializations
clear all; close all; clc;

im1= imread('../inputs/man1.jpg');
im2= imread('../inputs/man2.jpg');

n= size(im1, 1);  m= size(im1, 2);

nCDots= 10;

figure('name', 'man1'), imshow(im1);
x1= zeros(nCDots,1);  y1= zeros(nCDots,1);
hold on
for i=1:nCDots
    [x,y] = ginput(1);
    plot(x,y,'r.', 'MarkerSize', 15);
    x1(i)= x;  y1(i)= y; 
end
hold off
figure('name', 'man2'), imshow(im2);
x2= zeros(nCDots,1);  y2= zeros(nCDots,1);
hold on
for i=1:nCDots
    [x,y] = ginput(1);
    plot(x,y,'r.', 'MarkerSize', 15);
    x2(i)= x;  y2(i)= y; 
end
hold off


cPoints1= zeros(nCDots+4, 2);
cPoints1(1,:)=[1,1];
cPoints1(2,:)=[1,size(im1,2)];
cPoints1(3,:)=[size(im1,1),1];
cPoints1(4,:)=[size(im1,1),size(im1,2)];
cPoints1(5:end, :)= [x1, y1];

cPoints2= zeros(nCDots+4, 2);
cPoints2(1,:)=[1,1];
cPoints2(2,:)=[1,size(im2,2)];
cPoints2(3,:)=[size(im2,1),1];
cPoints2(4,:)=[size(im2,1),size(im2,2)];
cPoints2(5:end, :)= [x2, y2];

%% morphing
tic
nFrames= 6;
finalRes= zeros(n, m, 3, nFrames);
finalRes(:,:,:,1)= im1;

frame= 1;
for t=0.1:0.1:1
    frame= frame+1;
    
    avgCPoints= (1-t)*cPoints1 + t*cPoints2;
    TRI= delaunay(avgCPoints);
    
    [T1, T2]= findTheTransformation(cPoints1, cPoints2, avgCPoints, TRI);
    
    nAv= round(avgCPoints(4,1));  mAv= round(avgCPoints(4,2));
    res= zeros(nAv, mAv, 3);
    for i=1:nAv
        for j=1:mAv
            indx= tsearchn(avgCPoints, TRI, [i,j]);
            [X1, Y1]= transformPointsInverse(T1{indx},i,j);                                 
            [X2, Y2]= transformPointsInverse(T2{indx},i,j);
            
            res(i,j,:)= (1-t)*im1(round(X1),round(Y1),:) + t*im2(round(X2),round(Y2),:);
        end
    end
    res= imresize(res, n, m);
    finalRes(:,:,:,frame)= res;
end
toc
%% create the GIF
frame2gif(finalRes, 'hw6-q1.gif', 0.2, 1, 0);