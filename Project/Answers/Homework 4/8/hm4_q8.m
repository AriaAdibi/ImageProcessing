%% inputs & initializations
clear all; close all; clc;
orgIm= imread('theImage.jpg');
im= im2double(orgIm);

resizeFac= 0.2;
numSeg= 12;
im= imresize(im, resizeFac);
n= size(im,1); m= size(im,2);
gIm= rgb2gray(im);

F= makeLMfilters;
nF= size(F, 3);

%% Texture Segmentation
tic
featureV= zeros(n, m, nF);
for i=1:nF
    featureV(:, :, i)= conv2(gIm, F(:,:,i), 'same');
end
toc
%%
tic
rFeatureV= reshape( featureV, n*m, nF);
labels = kmeans(rFeatureV, numSeg);

labels= reshape( labels, n, m );
toc

%% draw borders
b1= conv2( labels, [1 0 -1], 'same' );
b1= b1~=0;
b1= cat(3, b1, b1, b1);

b2= conv2( labels, cat(1, 1, 0, -1), 'same' );
b2= b2~=0;
b2= cat(3, b2, b2, b2);

im(b1)= 0;
im(b2)= 0;
im= imresize(im, 1/resizeFac,'bicubic');

%% show result
figure('name', 'result', 'MenuBar', 'none'), imshow(im);