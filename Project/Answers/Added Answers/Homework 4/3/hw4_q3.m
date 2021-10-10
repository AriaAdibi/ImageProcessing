%% inputs & initializations
clear all; close all; clc;
orgIm= imread('../inputs/im023.jpg');
im= im2double(orgIm);

resizeFac= 1;
im= imresize(im, resizeFac);

gIm= rgb2gray(im);
gIm= imgaussfilt(gIm, 2, 'filtersize', 5);
[GMag, GDir]= imgradient(gIm);

%% Find Birds
n= size(gIm, 1); m= size(gIm, 2);

bGMagTh= 0.09;
birdsMask= GMag > bGMagTh;

leftCut= 520;
birdsMask(:,1:leftCut)= 0;

offTh= 200;
for j=m:-1:1
    c= birdsMask(:, j);
    indx= find(c, 1) + offTh;
    c(indx:end)= 0;
    birdsMask(:, j)= c;
end

bottomCut= 1000;
birdsMask(end-bottomCut:end, :)= 0;

chainThickness= 117;
for j=m:-1:leftCut*2
    c= birdsMask(:, j);
    indx= find(c, 1, 'last');
    c(indx-chainThickness:indx)= 0;
    birdsMask(:, j)= c;
end

%% fill in
filledIn= birdsMask;
for j=m:-1:1
    c= filledIn(:, j);
    fIndx= find(c, 1);
    lIndx= find(c, 1, 'last');
    c(fIndx:lIndx)= 1;
    filledIn(:, j)= c;
end

%%
filledIn= cat(3, filledIn, filledIn, filledIn);
result= im.*filledIn;
figure, imshow(result);
figure, imshow(birdsMask);