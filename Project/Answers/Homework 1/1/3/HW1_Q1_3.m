%% inputs & initializations
clear all;
orgIm= imread('../Images/HW1_Q1_3org.jpg');
I= double(orgIm);
%% image enhancements
    %% lightening
    lRes1= I;
    %{
    lRes1= cat(3, imgaussfilt(lRes1(:,:,1), 1, 'FilterSize', 3, 'Padding', 'symmetric'),...
                  imgaussfilt(lRes1(:,:,2), 1, 'FilterSize', 3, 'Padding', 'symmetric'),...
                  imgaussfilt(lRes1(:,:,3), 1, 'FilterSize', 3, 'Padding', 'symmetric'));
    %}        
    lRes1= 255 * (log(1 + 0.02*lRes1) / log(1 + 255*0.02));
    
    lRes2= lRes1;
    darkParts= sum(lRes2 < 10, 3)==3;
    %figure('name','darkParts'), imagesc(darkParts);
    dMask= cat(3, darkParts, darkParts, darkParts);
    lRes2(dMask)= 255*((lRes2(dMask)/255).^0.9);
    
    %{
    lRes3= lRes2;
    selPortions= logical([oC3th, ~oC3th, ~oC3th, zeros(720,2, 3)]);
    tooDark= sum(lRes3<20,3)==3;
    dMask= imfilter(uint8(tooDark), ones(7,7), 'replicate') > 40;
    dMask= cat(3, dMask, dMask, dMask);
    myMask= dMask & selPortions;
    lRes3(myMask)= 255 * (log(1 + lRes3(myMask)*0.02) / log(1 + 255*0.02));
    %}
    %figure('name', 'finalL picture'), imshow(uint8(lRes3));

    %% filers & output
    fRes1= lRes2;
    %{
    fRes1= cat(3, medfilt2(fRes1(:,:,1),'symmetric'),...
                  medfilt2(fRes1(:,:,2),'symmetric'),...
                  medfilt2(fRes1(:,:,3),'symmetric'));
    %}
    fRes1= cat(3, wiener2(fRes1(:,:,1),3),...
                  wiener2(fRes1(:,:,2),3),...
                  wiener2(fRes1(:,:,3),3));

    fRes2= fRes1;
    fRes2= cat(3, imgaussfilt(fRes2(:,:,1), 0.5, 'FilterSize', 3, 'Padding', 'symmetric'),...
                  imgaussfilt(fRes2(:,:,2), 0.5, 'FilterSize', 3, 'Padding', 'symmetric'),...
                  imgaussfilt(fRes2(:,:,3), 0.5, 'FilterSize', 3, 'Padding', 'symmetric'));
              
    finalRes= uint8(fRes2);
    figure('name', 'final picture'), imshow(finalRes);
    imwrite(finalRes, 'HW1_Q1_3res.jpg');