%% inputs & initializations
clear all;
orgIm= imread('im032.jpg');
im= orgIm;
im= imgaussfilt(im, 0.5, 'FilterSize', 3, 'Padding', 'symmetric');

%% change to purple
imHSV= rgb2hsv(im);
h= imHSV(:,:,1); s= imHSV(:,:,2); v= imHSV(:,:,3);

mask= (s > 0.5 & h > 0.01 & h < 0.2);
imHSV(mask) = 0.83 - imHSV(mask);

mask= (s < 0.6 & h > 0.9);
imHSV(mask) = 1.73 - imHSV(mask);

res= hsv2rgb(imHSV);
%{
res= cat(3, medfilt2(res(:,:,1),'symmetric'),...
            medfilt2(res(:,:,2),'symmetric'),...
            medfilt2(res(:,:,3),'symmetric'));
%}
figure('Name', 'Orange to Purple'); imshow(res);
imwrite(res, 'im032_purple.jpg');