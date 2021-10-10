%% inputs & initializations
clear all; close all; clc;
orgIm= imread('../inputs/sea.jpg');
theMask= imread('../inputs/mask.png');
im= im2double(orgIm);
im= imgaussfilt(im, 2, 'FilterSize', 7, 'Padding', 'symmetric');%TODO

hBoxSSize= 4;
overlap= 1;%TODO

%% fill the hole
%fillTheHole(im, theMask, step, matchStep, hBoxSSize)

tic
im= fillTheHole1(im, theMask, 5, 5, 12, overlap);
toc

%im, theMask, matchStep, hBoxSSize
%{
tic
im= fillTheHole2(im, theMask, 20, hBoxSSize);
toc
%}
%% show the result
figure, imshow(im);