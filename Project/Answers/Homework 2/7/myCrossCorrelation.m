function fCC= myCrossCorrelation(im, filter)
    filterSize= size(filter);
    center= (filterSize+1)./2;
    
    fCC= zeros( size(im) );
    
    for x= 1:1:filterSize(1)
        for y= 1:1:filterSize(2)
            dx= x - center(1);
            dy= y - center(2);
            fCC= fCC + imtranslate( filter(x,y).*im, [dx, dy] );
        end
    end
    
end
%%
function J = myConv(I, filter)
    I = padarray(I, [1 1]);
    filterSize = size(filter);
    imageSize = size(I);
    
    J = zeros(imageSize(1), imageSize(2));
    center = (filterSize + 1) ./ 2;
    for x = 1:filterSize(1)
        for y = 1:filterSize(2)
            dx = x - center(1);
            dy = y - center(2);
            tmp = filter(x, y) .* I;
            J = J + imtranslate(tmp, [dx, dy]);
        end
    end
end