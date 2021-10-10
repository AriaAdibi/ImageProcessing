function [lowPF, highPF]= getLowHighGuassianFilters(lowSigma, highSigma, imHH, imHW, imLH, imLW, cutoff)
    lowPF= fspecial('gaussian', [imLH, imLW], lowSigma);
    highPF= fspecial('gaussian', [imHH, imHW], highSigma);
%     center= [ imH/2, imW/2 ];
%     [H, W]= meshgrid(1:imH, 1:imW);
    
%     dist= sqrt( (H-center(1)).^2 + (W-center(2)).^2 );
%     lowMask= dist <= cutoff;
%     highMask= dist > cutoff;
    
    %lowPF= fftshift( fft2(lowPF) );
    %highPF= fftshift( fft2(highPF) );
    highPF= 1- highPF;
    
    lowPF= myNorm(lowPF);
    highPF= myNorm(highPF);
    
%     lowPF(highMask)= 0;
%     highPF(lowMask)= 0;
end