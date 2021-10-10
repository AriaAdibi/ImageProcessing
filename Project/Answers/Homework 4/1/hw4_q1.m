%% inputs & initializations
clear all; close all; clc;
orgIm= imread('../inputs/im016.jpg');
im= im2double(orgIm);

m= 260; %% TODO
rdcdIm= zeros( size(orgIm) );

sumSV= zeros( 1, 3 );
sumRdcdSV= zeros( 1, 3 );

cStr= cell(3);
cStr{1}= 'R'; cStr{2}= 'G'; cStr{3}= 'B';

%% reduction
for i=1:3
    [U, S, V]= svd(im(:,:,i), 'econ');
    
    approx_S= S(1:m, 1:m);
    
    rankRGB(i)= size(S,1);
    sumSV(i)= sum( diag(S) );
    sumRdcdSV(i)= sum( diag(approx_S) );
    
    figure, imshow( abs(log(U(:, 1:m))), [] );
    figure, imshow( abs(log(approx_S)), [] );
    figure, imshow( abs(log(V(:, 1:m))), [] );
    
    rdcdIm(:,:,i)= U(:, 1:m) * approx_S * V(:, 1:m)';
end

%% output orgIm and rdcdIm
fig0=figure('name', 'Original Image');
fig0.MenuBar= 'none';
imshow(orgIm);

fig1= figure('name', 'Reduced Image');
fig1.MenuBar= 'none';
imshow(rdcdIm);

%% calculate "space saving"
for i=1:3
    s= 2*m+1;
    r= 2*rankRGB(i)+1;
    spSV(i)= 1- s/r;
    disp( sprintf('"Space saving of channel %s"= %d', cStr{i}, spSV(i)) );
end
disp( sprintf('Mean "space saving"= %d \n', mean(spSV)) );

%% calculate Entropies
%original image
disp( 'Entopy in original image:' );
for i=1:3
    e(i)= entropy(im(:,:,i));
    disp( sprintf('Entropy %s= %d', cStr{i}, e(i)) );
end
disp( sprintf('Mean Entropies= %d \n', mean(e)) );

%reduced image
disp( 'Entopy in reduced image:' );
for i=1:3
    e(i)= entropy(rdcdIm(:,:,i));
    disp( sprintf('Entropy %s= %d', cStr{i}, e(i)) );
end
disp( sprintf('Mean Entropies= %d \n', mean(e)) );

%% report sum diag
disp('Sum of "Singular Values":');
for i=1:3
    disp( sprintf('The sum in orignial image, channel %s= %d', cStr{i}, sumSV(i)) );
    disp( sprintf('The sum in reduced image, channel %s= %d \n', cStr{i}, sumRdcdSV(i)) );
end
disp( sprintf('The sum in orignial image= %d', sum(sumSV) ) );
disp( sprintf('The sum in reduced image= %d', sum(sumRdcdSV) ) );
