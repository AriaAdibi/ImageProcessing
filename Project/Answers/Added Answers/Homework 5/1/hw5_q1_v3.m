%% inputs & initializations
clear all; close all; clc;
orgIm= imread('../inputs/tasbih.jpg');
im= im2double(orgIm);

OO= 100 * 1000 * 1000;

PStep= 10;

nIteration= 300;
m= 9; %Searching in m*m - MUST BE ODD
alpha= 0.002;
gamma= 10;

smoothSigma= 2.5;
smoothFSize= 7;
%removable
resizeFactor= 0.5;
im= imresize(im, resizeFactor);
%}
figure('name', 'Choose your ROI'), imshow(im);
roiBW= roipoly;

nItPerFrame= 1;
videoPath = './hw5_q1_video_v2.avi';
writerObj = VideoWriter(videoPath);
open(writerObj);

%% TODO 
% maybe reduce the edges in unwanted areas
gIm= rgb2gray(im);
%removable
gIm= imgaussfilt(gIm, smoothSigma, 'filtersize', smoothFSize);
%} 

%% Calculate Gradient and points
[Gmag, Gdir]= imgradient(gIm);
points = bwboundaries(roiBW);
points = points{1}(1:PStep:end, :);

SAVE= points;
%% Find Good Contour using dynamic programming
tic
points= SAVE;

st= 1;
n= size(points, 1);
for it=1:nIteration
    %
    avgD= 0;
    for i=1:n
        p= points(i,:);
        q= points( nextIndx(i, n), : );
        avgD= avgD + sqrt( sum((p-q).^2) );
    end
    avgD= avgD/(1.4*n);
    %}
    [E_last, lastIndx, par]= dynamicPosEval_v5(points, st, Gmag, m, OO, alpha, gamma, avgD);
    points= moveThePoints_v3(points, m, E_last, lastIndx, par, OO);
    st= nextIndx(st, n);
    
    if( mod(it, nItPerFrame)==0 )
        fig = figure('visible', 'off');
        imshow(im);
        hold on               
        
        shPoints= cat(1, points, [points(1,1), points(1,2)]);
        plot(shPoints(:,2), shPoints(:,1), 'g', 'markersize', 10 );
        plot(shPoints(:,2), shPoints(:,1), 'k.', 'markersize', 6 );
            
        F = getframe(fig);
        writeVideo(writerObj, F.cdata);
        close(fig);
    end
end

close(writerObj);
toc