%% inputs & initializations
clear all;
orgIm1= imread('im033.jpg');
orgIm2= imread('im015.jpg');
Im1= orgIm1;
Im2= orgIm2;

%% change to desired histogram
desHist= imhist(Im2, 256);
nHIm1 = histeq(Im1, desHist);
imwrite(nHIm1, 'im033_hist.jpg');
figure('Name', 'Im033 with desired histogram'); imshow(nHIm1);

%% plot the differences
diff = abs(imhist(Im1, 256) - imhist(nHIm1, 256));
figure('Name', 'Histogram Differences');
fig= gcf, fig.ToolBar = 'none';
bar(diff, 'hist');
print('im033_diff', '-djpeg');

%% median filter
res = medfilt2(nHIm1, [7 7], 'symmetric');
figure('Name', 'Final Image'); imshow(res);
imwrite(res, 'im033_hismed.jpg');