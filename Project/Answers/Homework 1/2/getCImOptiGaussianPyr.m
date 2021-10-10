function[coloredIm]= getCImOptiGaussianPyr(croppedBIm)
    %initializations
    [B, G, R]= getRGB(croppedBIm);
    R= im2double(R);
    G= im2double(G);
    B= im2double(B);
    
    redFactor= 3; %TODO
    redR= redIm(R, redFactor);
    redG= redIm(G, redFactor);
    redB= redIm(B, redFactor);
    %% find matches
    for i=1:redFactor
        disPRG= findBestDisPForL(redR, redG, 25, 5);
        
        iSecRR= redR( max([1, 1+disPRG(1)]) : min([end, size(redG,1)+disPRG(1)]), ...
                          max([1, 1+disPRG(2)]) : min([end, size(redG,2)+disPRG(2)]) );              
        iSecRG= redG(max([1, 1-disPRG(1)]) : min( [end, end-(disPRG(1)-(size(redR,1)-size(redG,1)))] ), ...
                 max([1, 1-disPRG(2)]) : min( [end, end-(disPRG(2)-(size(redR,2)-size(redG,2)))] ), :);
        redRG= cat(3, iSecRR, iSecRG);
       
        disPRGB= findBestDisPForL(redB, redRG, 25, 5);
        
        iSecRB= redB( max([1, 1+disPRGB(1)]) : min([end, size(redRG,1)+disPRGB(1)]), ...
                          max([1, 1+disPRGB(2)]) : min([end, size(redRG,2)+disPRGB(2)]) );
        iSecRR= redRG(max([1, 1-disPRGB(1)]) : min( [end, end-(disPRGB(1)-(size(redB,1)-size(redRG,1)))] ), ...
             max([1, 1-disPRGB(2)]) : min( [end, end-(disPRGB(2)-(size(redB,2)-size(redRG,2)))] ), 1);
        iSecRG= redRG(max([1, 1-disPRGB(1)]) : min( [end, end-(disPRGB(1)-(size(redB,1)-size(redRG,1)))] ), ...
             max([1, 1-disPRGB(2)]) : min( [end, end-(disPRGB(2)-(size(redB,2)-size(redRG,2)))] ), 2);
        
         
        redR= imresize(iSecRR, 2, 'bicubic');
        redG= imresize(iSecRG, 2, 'bicubic');
        redB= imresize(iSecRB, 2, 'bicubic');
    end
    %
        disPRG= findBestDisPForL(redR, redG, 8, 1);
        
        iSecRR= redR( max([1, 1+disPRG(1)]) : min([end, size(redG,1)+disPRG(1)]), ...
                          max([1, 1+disPRG(2)]) : min([end, size(redG,2)+disPRG(2)]) );              
        iSecRG= redG(max([1, 1-disPRG(1)]) : min( [end, end-(disPRG(1)-(size(redR,1)-size(redG,1)))] ), ...
                 max([1, 1-disPRG(2)]) : min( [end, end-(disPRG(2)-(size(redR,2)-size(redG,2)))] ), :);
        redRG= cat(3, iSecRR, iSecRG);
       
        disPRGB= findBestDisPForL(redB, redRG, 8, 1);
        
        iSecRB= redB( max([1, 1+disPRGB(1)]) : min([end, size(redRG,1)+disPRGB(1)]), ...
                          max([1, 1+disPRGB(2)]) : min([end, size(redRG,2)+disPRGB(2)]) );
        iSecRR= redRG(max([1, 1-disPRGB(1)]) : min( [end, end-(disPRGB(1)-(size(redB,1)-size(redRG,1)))] ), ...
             max([1, 1-disPRGB(2)]) : min( [end, end-(disPRGB(2)-(size(redB,2)-size(redRG,2)))] ), 1);
        iSecRG= redRG(max([1, 1-disPRGB(1)]) : min( [end, end-(disPRGB(1)-(size(redB,1)-size(redRG,1)))] ), ...
             max([1, 1-disPRGB(2)]) : min( [end, end-(disPRGB(2)-(size(redB,2)-size(redRG,2)))] ), 2);
         
        redR= iSecRR; redG= iSecRG; redB= iSecRB;
    %}
    coloredIm= cat(3, redR, redG, redB);
end

%{
function[k]= gaussianKernel(size, sigma)
    K = zeros(Size, Size);
    sum = 0;
    for i=1:size
        for j=1:size
            %TODO
            k(i,j) = exp(-((i-size/2).^2+(j-size/2).^2)/(2*sigma.^2))/(2*pi*sigma.^2);
            sum = sum + k(i,j);
        end;
    end;
    k= k./sum;
end
%}

%%
function [reducedIm]= redIm(im, redF)
    reducedIm= im;
    for i=1:redF
        reducedIm= imgaussfilt(reducedIm, 1, 'FilterSize', 3, 'Padding', 'symmetric');
        reducedIm= imresize(reducedIm, 0.5, 'nearest');
    end
end