function theMatch= findTheMatch1(im, theMask, box, step, hBoxSSize)
    inf= 5000;%TODO
    g= fspecial('gaussian', 2*hBoxSSize+1, 1 );%TODO
    g= cat(3, g, g, g);

    n= size(im,1); m= size(im,2);
    affScores= zeros( n, m ); %TODO
    affScores(:)= inf;
    
    aprCompMask= box(:,:,1)>0 | box(:,:,2)>0 | box(:,:,3)>0;
    aprCompMask= cat(3, aprCompMask, aprCompMask, aprCompMask);
    
    box= box/( sum(sum(sum(box))) );%TODO
    
    for i=1+hBoxSSize : step : n-hBoxSSize
        for j=1+hBoxSSize : step : m-hBoxSSize
            if( theMask(i,j) == 0 )%TODO
                pMatch= im(i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize, :);
                pMatch= pMatch.*aprCompMask;%TODO
                pMatch= pMatch/( sum(sum(sum(pMatch))) );%TODO

                affScores(i, j)= sum(sum(sum( ((box-pMatch).^2).*g )));
            end
        end
    end

    [minVal, theIndx]= min( affScores(:) );
    [i,j]= myInd2Sub(n, theIndx);

    theMatch=im(i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize, :);
end