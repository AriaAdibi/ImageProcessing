%% inputs & initializations
clear all;
orgIm= imread('../Images/1.jpg');
I= double(orgIm);

%% image enhancements
    %% lightening
    res1= 255 * (log(1 + 0.6*I) / log(1 + 255*0.6));

    darkParts= sum(res1 < 25, 3)==3;
    %figure('name','darkParts'), imagesc(darkParts);
    dMask= cat(3, darkParts, darkParts, darkParts);
    res2= res1;
    res2(dMask)= 255*((res2(dMask)/255).^0.9);

    %% filers & output
    %{
    res3= cat(3, medfilt2(res2(:,:,1),'symmetric'),...
                 medfilt2(res2(:,:,2),'symmetric'),...
                 medfilt2(res2(:,:,3),'symmetric'));
    %}

    res3= cat(3, wiener2(res2(:,:,1),[5 5]),...
                 wiener2(res2(:,:,2),[5 5]),...
                 wiener2(res2(:,:,3),[5 5]));

    %res4= imfilter(res3, fspecial('gaussian'), 'replicate');
    res4= imgaussfilt3(res3, 2, 'FilterSize', [7,7,3], 'Padding', 'symmetric');
    %{
    res4= cat(3, imgaussfilt(res3(:,:,1), 2, 'FilterSize', 7, 'Padding', 'symmetric'),...
                 imgaussfilt(res3(:,:,2), 2, 'FilterSize', 7, 'Padding', 'symmetric'),...
                 imgaussfilt(res3(:,:,3), 2, 'FilterSize', 7, 'Padding', 'symmetric'));
    %}
    
    finalRes= uint8(res4);
    figure('name', 'final picture'), imshow(finalRes);
    imwrite(finalRes, 'HW1_Q1_1.jpg');