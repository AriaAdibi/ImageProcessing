%% inputs & initializations
clear all;
orgIm= imread('im033_hist.jpg');
im= im2double(orgIm);

%% guass filter
gaussF= fspecial('gaussian', 5, 2);
figure('Name', 'Gaussian Filter-Sigma=2');
fig= gcf; fig.ToolBar = 'none';
imagesc(gaussF);

%% applying Guassian filter
tic
myGFiltered= myCrossCorrelation(im, gaussF);
toc;
myGFiltered= myNormalization(myGFiltered);

imwrite(myGFiltered, 'gauss_man.jpg');
figure('Name', 'gauss_man'); imshow(myGFiltered);
fig= gcf; fig.ToolBar = 'none';

%% applying Guassian filter using separated filters
[isSeparatable, gaussFRow, gaussFCol]= isfilterseparable(gaussF);

figure('Name', 'Gaussian Filter-Row-Sigma=2');
fig= gcf; fig.ToolBar = 'none';
imagesc( abs(gaussFRow) );

figure('Name', 'Gaussian Filter-Col-Sigma=2');
fig= gcf; fig.ToolBar = 'none';
imagesc( abs(gaussFCol) );

tic
myGFRow = myCrossCorrelation(im, gaussFRow);
myGFCol = myCrossCorrelation(myGFRow, gaussFCol);
toc;
myGFRow= myNormalization(myGFRow);
myGFCol= myNormalization(myGFCol);

imwrite(myGFRow, 'gauss_man_row.jpg');
figure('Name', 'gauss_man_row'); imshow(myGFRow);
fig= gcf; fig.ToolBar = 'none';

imwrite(myGFCol, 'gauss_man_col.jpg');
figure('Name', 'gauss_man_col'); imshow(myGFCol);
fig= gcf; fig.ToolBar = 'none';

%% Again without separation using imfilter
tic
myGFiltered2= imfilter(im, gaussF);
toc;
myGFiltered2= myNormalization(myGFiltered2);

imwrite(myGFiltered2, 'gauss_fil.jpg');
figure('Name', 'gauss_man_2'); imshow(myGFiltered2);
fig= gcf; fig.ToolBar = 'none';

%% Again with separation using imfilter
tic
myGFRow2 = imfilter(im, gaussFRow);
myGFCol2 = imfilter(myGFRow2, gaussFCol);
toc;
myGFRow2= myNormalization(myGFRow2);
myGFCol2= myNormalization(myGFCol2);

imwrite(myGFRow2, 'gauss_fil_row.jpg');
figure('Name', 'gauss_man_row_2'); imshow(myGFRow2);
fig= gcf; fig.ToolBar = 'none';

imwrite(myGFCol2, 'gauss_fil_col.jpg');
figure('Name', 'gauss_man_col_2'); imshow(myGFCol2);
fig= gcf; fig.ToolBar = 'none';