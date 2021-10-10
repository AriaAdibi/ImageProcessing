%% inputs & initializations
tic
clear all; close all; clc;

%qtms must be for specified boxSSize
qtms= dlmread('../inputs/2/Quantums.txt');

resizeFactor= 10;
boxSSize= 8;
boxSize= 64;

load('encoInfo.mat');

%% decode the encoIm
theList= huffmandeco(encoIm, dict);

im= zeros( n, m );
for i=1:n/boxSSize
    for j=1:m/boxSSize
        x= (i-1)*boxSSize+1 : i*boxSSize;
        y= (j-1)*boxSSize+1 : j*boxSSize;
        indx= (i-1)*m/boxSSize*boxSize + (j-1)*boxSize + 1;
        
        box= iZigzagScan( theList(indx : indx+boxSize-1) );
        box= box.*qtms;
        box= idct2(box);
        im(x, y)= box;
    end
end

%% crop and resize + show
im= im(1:N, 1:M);
im( im>255 ) = 255;
im= uint8(im);
im= imresize(im, resizeFactor);
figure('name', 'The Image'), imshow(im);
toc