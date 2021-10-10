%% inputs and initializations
clear all; clc; warning('off'); close all;
orgIm1= imread('image1.jpg');
orgIm2= imread('image2.jpg');
im1= im2double(orgIm1);
im2= im2double(orgIm2);

%% align
[im1, im2] = align_2im(im1 , im2);

figure('Name', 'Image1 Aligned');
imshow(im1);
imwrite(im1 ,'Image1 Aligned.jpg');

figure('Name', 'Image2 Aligned');
imshow(im2);
imwrite(im2 ,'Image2 Aligned.jpg');

%% find and show DFTs
DFT_Im1= fftshift( fft2(im1) );
DFT_Im2= fftshift( fft2(im2) );

figure('Name', 'DFT Image1');
imshow(myNorm( log(abs(DFT_Im1)) ));
imwrite(myNorm( log(abs(DFT_Im1)) ) ,'DFT Image1.jpg');

figure('Name', 'DFT Image2');
imshow(myNorm( log(abs(DFT_Im2)) ));
imwrite(myNorm( log(abs(DFT_Im2)) ) ,'DFT Image2.jpg');

%% find and show high pass and low pass filtered images
cutoff= 50;
[imHH, imHW, imHD]= size(im1);
[imLH, imLW, imLD]= size(im2);

lowSigma= 10; highSigma= 15;
[lowPF, highPF]= getLowHighGuassianFilters(lowSigma, highSigma, imHH, imHW, imLH, imLW, cutoff);

lowPFiltered= DFT_Im2;
for i=1:1:imLD
    lowPFiltered(:, :, i)= lowPFiltered(:, :, i).* (lowPF);
end

highPFiltered= DFT_Im1;
for i=1:1:imHD
    highPFiltered(:, :, i)= highPFiltered(:, :, i).* (highPF);
end

figure('Name', 'Low pass filter');
imshow( lowPF );
imwrite( lowPF, sprintf('lowpass_%d.jpg', lowSigma) );

figure('Name', 'High pass filter');
imshow( highPF );
imwrite( highPF, sprintf('highpass_%d.jpg', highSigma) );

%% create the hybrid image in frequency domain
hybrid_im= lowPFiltered+ highPFiltered;

hybrid_im= ifft2(ifftshift(hybrid_im));

figure('Name', 'Hybrid image frequency domain');
hybrid_im= hybrid_im(250:end-15, :, :);
imshow( hybrid_im );
imwrite( hybrid_im, 'Hybrid image frequency domain.jpg' );

%% create the hybrid image in spatial domain
smoothed= imgaussfilt(im2, 2);
sharppend= 2*im1 - imgaussfilt(im1, 7);
hybrid_SIm= 0.7*(smoothed + 0.5*sharppend);

figure('Name', 'Hybrid image spacial domain');
hybrid_SIm= hybrid_SIm(280:end-15, :, :);
imshow( hybrid_SIm );
imwrite( hybrid_SIm, 'Hybrid image spacial domain.jpg' );