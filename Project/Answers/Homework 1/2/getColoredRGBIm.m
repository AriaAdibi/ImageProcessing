function[coloredIm]= getColoredRGBIm(croppedBIm)
    %RBG to double (0,1)
    [B, G, R]= getRGB(croppedBIm);
    R= im2double(R);
    G= im2double(G);
    B= im2double(B);
    
    %% find matches 
    disPRG= findBestDisPForL(R, G, 20, 1);
    
    iSecR= R( max([1, 1+disPRG(1)]) : min([end, size(G,1)+disPRG(1)]), ...
                      max([1, 1+disPRG(2)]) : min([end, size(G,2)+disPRG(2)]) );              
    iSecG= G(max([1, 1-disPRG(1)]) : min( [end, end-(disPRG(1)-(size(R,1)-size(G,1)))] ), ...
             max([1, 1-disPRG(2)]) : min( [end, end-(disPRG(2)-(size(R,2)-size(G,2)))] ), :);
    
    RG= cat(3, iSecR, iSecG);
    disPRGB= findBestDisPForL(B, RG, 20, 1);
    
    iSecB= B( max([1, 1+disPRGB(1)]) : min([end, size(RG,1)+disPRGB(1)]), ...
                      max([1, 1+disPRGB(2)]) : min([end, size(RG,2)+disPRGB(2)]) );              
    iSecRG= RG(max([1, 1-disPRGB(1)]) : min( [end, end-(disPRGB(1)-(size(B,1)-size(RG,1)))] ), ...
             max([1, 1-disPRGB(2)]) : min( [end, end-(disPRGB(2)-(size(B,2)-size(RG,2)))] ), :);
    
    coloredIm= cat(3, iSecRG, iSecB);
end