function [im, theMask]= fillTheHole1(im, theMask, step, matchStep, hBoxSSize, overlap)
    n= size(im,1); m= size(im, 2);
    alpha= 0.8;
    alMask= ones( (2*hBoxSSize+1), (2*hBoxSSize+1), 3 );
    alMask(1:overlap,:,:)= alpha;
    alMask(end-overlap:end,:,:)= alpha;
    alMask(:,1:overlap,:)= alpha;
    alMask(:,end-overlap:end,:)= alpha;
    
    for i=1+hBoxSSize : step : n-hBoxSSize
        for j=1+hBoxSSize : step : m-hBoxSSize
            if( theMask(i,j) == 1 )
                box= im(i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize, :);
                theMatch= findTheMatch1(im, theMask, box, matchStep, hBoxSSize);
                %blendTheMatch()
                theMatch= theMatch.*alMask + box.*( ones( (2*hBoxSSize+1), (2*hBoxSSize+1), 3 )-alMask );
                im(i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize, :)= theMatch;
                theMask( i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize )= ...
                    theMatch(:,:,1)==0 &  theMatch(:,:,2)==0 & theMatch(:,:,3)==0;%TODO
            end
        end
    end 
end