function theMatch= findTheMatch2(im, theMask, box, step, hBoxSSize)
    inf= 5000;%TODO
    g= fspecial('gaussian', 2*hBoxSSize+1, 1 );%TODO
    g= cat(3, g, g, g);

    n= size(im,1); m= size(im,2);
    affScores= zeros( n, m ); %TODO
    affScores(:)= inf;
    
    aprCompMask= box(:,:,1)>0 | box(:,:,2)>0 | box(:,:,3)>0;
    aprCompMask= cat(3, aprCompMask, aprCompMask, aprCompMask);
    
    vBoxSize= (2*hBoxSSize+1)^2*3 - ( (2*hBoxSSize+1)^2*3 - sum(sum(sum(aprCompMask))) );
    
    meanBox= sum(sum(sum(box))) / vBoxSize;
    zMBox= (box-meanBox).*aprCompMask;
    sigmaBox= sum(sum(sum( zMBox.^2 )));
    
    for i=1+hBoxSSize : step : n-hBoxSSize
        for j=1+hBoxSSize : step : m-hBoxSSize
             if( theMask(i,j) == 0 )%TODO
                pMatch= im(i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize, :);

                pMatch= pMatch.*aprCompMask;
                meanPMatch= sum(sum(sum(pMatch))) / vBoxSize;
                zMPMatch= (pMatch-meanPMatch).*aprCompMask;
                sigmaPMatch= sum(sum(sum( zMPMatch.^2 )));

                affScores(i, j)= sum(sum(sum( zMBox.*zMPMatch ))) / (sigmaBox*sigmaPMatch)^0.5;
            end
        end
    end

    [minVal, theIndx]= min( affScores(:) );
    [i,j]= myInd2Sub(n, theIndx);

    theMatch=im(i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize, :);
end