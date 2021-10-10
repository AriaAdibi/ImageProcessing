%% inputs & initializations
clear all;
orgIm= imread('q8.jpg');
im= im2double(orgIm);

%% applying gaussian filter
gF= imgaussfilt(im, 2, 'FilterSize', 11, 'Padding', 'symmetric');

imwrite(gF, 'q8_gauss.jpg');
figure('Name', 'q8_gauss.jpg'); imshow(gF);
fig= gcf; fig.ToolBar = 'none';
%% applying bilateral filter
bLF= bfilter2(im, 5.5, 2);

imwrite(bLF, 'q8_bilateral.jpg');
figure('Name', 'q8_bilateral.jpg'); imshow(bLF);
fig= gcf; fig.ToolBar = 'none';