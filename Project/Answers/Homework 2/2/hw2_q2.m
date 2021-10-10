%% inputs & initializations
clear all;
orgIm= imread('im033.jpg');
im= im2double(orgIm);
im= imgaussfilt(im, 1, 'FilterSize', 3, 'Padding', 'symmetric');

%% get Gradient X and Y
%->Y
%|
%X
sobelY= [1 2 1; 0 0 0; -1 -2 -1];
sobelX= [1 0 -1; 2 0 -2; 1 0 -1];

yG= abs( conv2(im, sobelY) );
xG= abs( conv2(im, sobelX) );

imwrite(yG, 'im033_y.jpg');
figure('Name', 'Horizontal Gradient'); imshow(myNormalization(yG));
imwrite(xG, 'im033_x.jpg');
figure('Name', 'Vertical Gradient'); imshow(myNormalization(xG));

%% get magnitude & direction
magG= (xG.^2 + yG.^2).^0.5;
imwrite(magG, 'im033_m.jpg');
figure('Name', 'Gradient Magnitude');  imshow(myNormalization(magG));

dirG= abs(atan(yG./xG));
imwrite(dirG, 'im033_d.jpg');
figure('Name', 'Gradient Direction');  imshow(myNormalization(dirG));

%% get the Edges
edges = magG;
edges(edges<=0.05) = 0;
imwrite(edges, 'im033_edge.jpg');
figure('Name', 'Edges'); imshow(edges);
