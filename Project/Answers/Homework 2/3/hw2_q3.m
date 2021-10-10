%% inputs & initializations
clear all;
orgIm= imread('im015.jpg');
im= im2double(orgIm);

%% apply Laplacian filter
%gaussF= imgaussfilt(im, 1, 'FilterSize', 3, 'Padding', 'symmetric');
lapF= imfilter(im, fspecial('laplacian'), 'replicate');
imwrite(lapF, 'im015_L.jpg');
figure('Name', 'Laplacian'); imshow(lapF);

%% sharpen the image
shIm= im + lapF;
imwrite(shIm, 'im015_sh.jpg');
figure('Name', 'Sharpened'); imshow(shIm);