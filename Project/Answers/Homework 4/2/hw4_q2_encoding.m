%% inputs & initializations
clear all; close all; clc;
orgIm= imread('../inputs/harvesters.tif');
%converting to 8bit representation
im= im2uint8(orgIm);

%qtms must be for specified boxSSize
qtms= dlmread('../inputs/2/Quantums.txt');

boxSSize= 8;
boxSize= 64;

resizeFactor= 0.1;
im= imresize(im, resizeFactor);

[N,M]= size(im);

padSize= [boxSSize, boxSSize]- mod( [N,M], boxSSize );
im= padarray( im, padSize, 'symmetric', 'post' );
[n,m]= size(im);
%% encode the image
theList= zeros( 1, numel(im) );
for i=1:n/boxSSize
    for j=1:m/boxSSize
        x= (i-1)*boxSSize+1 : i*boxSSize;
        y= (j-1)*boxSSize+1 : j*boxSSize;
        indx= (i-1)*m/boxSSize*boxSize + (j-1)*boxSize + 1;
        theList(indx : indx+boxSize-1)= DCTAndQuantization(im(x,y), qtms);
    end
end

convTheList= round(theList);
symbs= unique(convTheList);
pr= histc( convTheList, symbs )./numel(convTheList);

[dict,avglen] = huffmandict(symbs,pr);
encoIm= huffmanenco(convTheList, dict);

%% saving
save( 'encoInfo.mat', 'n', 'm', 'N', 'M', 'dict', 'encoIm');