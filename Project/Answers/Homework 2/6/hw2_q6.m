%% inputs & initializations
clear all;
orgIm= imread('im033.jpg');
im= im2double(orgIm);

%% obtain Integral image
intIm= myNormalization(integralImage(im));

figure('Name', 'Integral Image'); imshow(intIm);
imwrite(intIm, 'im033_integral.jpg');