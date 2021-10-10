function [coloredIm]= fixPurple(cIm)
    oC12th= ones(size(cIm,1), size(cIm,2)/12);
    selParts= logical([oC12th,...
                       ~oC12th, ~oC12th, ~oC12th, ~oC12th, ~oC12th,...
                       ~oC12th, ~oC12th, ~oC12th, ~oC12th, ~oC12th,...
                       oC12th]);
    myMask= (cIm(:,:,2)<=15) & selParts;
    G= cIm(:,:,2);
    G(myMask)= G(myMask)+220;
    G= medfilt2(G,'symmetric');
          
    cIm(:,:,2)= G;
    coloredIm= cIm;
end