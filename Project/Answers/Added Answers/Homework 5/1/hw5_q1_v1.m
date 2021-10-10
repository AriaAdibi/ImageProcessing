%% inputs & initializations
clear all; close all; clc;
orgIm= imread('../inputs/tasbih.jpg');
im= im2double(orgIm);

figure('name', 'Choose your ROI'), imshow(im);
roiBW= roipoly;

nIteration= 50;
m= 9; %Searching in m*m - MUST BE ODD
alpha= 0.01;
gamma= 1;
OO= 10 * 1000 * 1000;%TODO value
PStep= 25; %TODO
%% TODO 
 % maybe reduce the edges in unwanted areas
%% Calculate Gradient and points
gIm= rgb2gray(im);

[Gmag, Gdir]= imgradient(gIm);
points = bwboundaries(roiBW);
points = points{1}(1:PStep:end, :);

%TODO
hold on
n= size(points, 1);
plot(points(:,2), points(:,1), 'y', 'markersize', 8 );

%%%
SAVE= points;
%% Find Good Contour using dynamic programming
tic
points= SAVE;%%
n= size(points, 1);
for it=1:nIteration
    %{
    avgD= 0;
    for i=1:n
        p= points(i,:);
        if( i~=n )
            q= points(i+1,:);
        else
            q= points(1,:);
        end
        avgD= avgD + sqrt( sum((p-q).^2) );
    end
    avgD= avgD/n;
    %}
    
    [E_n, par]= dynamicPosEval_v2(points, Gmag, m, OO, alpha, gamma);
    points= moveThePoints_v2(points, m, E_n, par, OO);
    %plot(points(:,2), points(:,1), 'b.', 'markersize', 4 );
end
toc
%%
%TODO
plot(points(:,2), points(:,1), 'b', 'markersize', 8 );