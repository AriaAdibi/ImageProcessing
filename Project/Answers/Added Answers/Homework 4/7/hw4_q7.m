%% inputs & initializations
clear all; close all; clc;
orgIm= imread('../inputs/im033.jpg');
im= orgIm;

%%%TODO
resizeFactor= 0.25;
im= imresize(im, resizeFactor);

%% Find Super Pixels
tic
imLAB = im2single( vl_xyz2lab(vl_rgb2xyz(im)) );
sPixelsLabels = vl_slic(imLAB, 20, 20);

%% 
labels= unique(sPixelsLabels);

I= im;
figure, imshow(I);
hold on
R= I(:,:,1); G= I(:,:,2); B= I(:,:,3);
for l=0:size(labels,1)
    mask= sPixelsLabels==l;
    R(mask)= 255;
    G(mask)= 0;
    B(mask)= 0;
    I= cat(3, R, G, B);
    imshow(I);
end
toc