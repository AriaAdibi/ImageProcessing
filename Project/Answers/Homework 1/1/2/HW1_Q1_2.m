%% inputs & initializations
clear all;
orgIm= imread('../Images/2.jpg');
I= double(orgIm);

oC3th= ones(size(I,1), size(I,2)/3, 3);
oC6th= ones(size(I,1), size(I,2)/6, 3);
oC4th= ones(size(I,1), size(I,2)/4, 3);
o9th= ones(size(I,1)/3, size(I,2)/3, 3);
z9th= zeros(size(I,1)/3, size(I,2)/3, 3);
o12th= ones(size(I,1)/3, size(I,2)/4, 3);
z12th= zeros(size(I,1)/3, size(I,2)/4, 3);
o18th= ones(size(I,1)/3, size(I,2)/6, 3);
z18th= zeros(size(I,1)/3, size(I,2)/6, 3);
%% image enhancements
    %% lightening
               
    selPortions12th= logical([ [[o12th;o12th]; z12th],...
                             oC4th, oC4th, ...
                             [z12th; [o12th;o12th]] ]);
    selPortions12thTR= ~logical([ [[o12th;o12th]; o12th],...
                             oC4th, oC4th, ...
                             [z12th; [o12th;o12th]] ]);                         
    selPortions12thBL= ~logical([ [[o12th;o12th]; z12th],...
                             oC4th, oC4th, ...
                             [o12th; [o12th;o12th]] ]);               
    selPortions9thBlur= ~logical([ [[o9th;o9th]; z9th],...
                            oC3th, ...
                            [o9th; [o9th;o9th]] ]);
              
    I(selPortions9thBlur)= imgaussfilt3(I(selPortions9thBlur), 4, 'FilterSize', 3, 'Padding', 'symmetric');
    
    lRes1= I;
    tooDark= sum(lRes1<40,3)==3;
    dMask= cat(3, tooDark, tooDark, tooDark);
    
    myMask= dMask & selPortions12thTR;
    lRes1(myMask)= 255 * (log(1 + lRes1(myMask)*0.11) / log(1 + 255*0.11));
    
    myMask= dMask & selPortions12thBL;
    lRes1(myMask)= 255*((lRes1(myMask)/255).^0.5);
    
    dMask= imfilter(uint8(tooDark), ones(7,7), 'replicate') > 40;
    dMask= cat(3, dMask, dMask, dMask);
    myMask= dMask & selPortions12th;
    lRes1(myMask)= 255 * (log(1 + lRes1(myMask)*0.11) / log(1 + 255*0.11));
    
    %{
        finalRes= uint8(lRes1);
        figure('name', 'finalL picture'), imshow(finalRes);
    %}
    %% filers & output
    fRes1= lRes1;
    finalRes= uint8(fRes1);
    figure('name', 'final picture'), imshow(finalRes);
    imwrite(finalRes, 'HW1_Q1_2.jpg');