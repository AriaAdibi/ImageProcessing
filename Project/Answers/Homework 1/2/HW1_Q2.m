%% tobolsk
    clear all; clc;
    %% reading & initializing
    orgIm= imread('./Images/tobolsk.jpg');
    croppedBIm= orgIm(26:end-25, 26:end-25);
    %% find best match
    cIm= im2uint8( getColoredRGBIm(croppedBIm) );
    %% finilize and output
    cIm= cIm(:, 10:end, :);
    figure('name', 'Tobolsk Image'), imshow(cIm);
    imwrite(cIm, 'HW1_Q2_tobolsk.jpg');
%% settlers %TODO
    clear all; clc;
    %% reading & initializing
    orgIm= imread('./Images/settlers.jpg');
    croppedBIm= orgIm(26:end-25, 26:end-25);
    %% find best match
    cIm= im2uint8( getColoredRGBIm(croppedBIm) );
    %% finilize and output
    cIm= cIm(5:end-40, 5:end-17, :);
    cIm= fixPurples(cIm);
    figure('name', 'Settlers Image'), imshow(cIm);
    imwrite(cIm, 'HW1_Q2_settlers.jpg');
%% harvesters
    clear all; clc;
    %% reading & initializing
    orgIm= imread('./Images/harvesters.tif');
    croppedBIm= orgIm(211:end-180, 171:end-195);
    %figure('name', 'Testing Borders'), imshow(croppedBIm);
    %% find best match
    tic;
    cIm= getCImOptiGaussianPyr(croppedBIm);
    toc;
    %% finilize and output
    fCIm= cIm;
    fCIm= fCIm(20:end-60, 130:end-50, :);
    figure('name', 'Harvesters Image'), imshow(fCIm);
    imwrite(fCIm, 'HW1_Q2_harvesters.jpg');
