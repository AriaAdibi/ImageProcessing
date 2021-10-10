function [im, theMask]= fillTheHole2(im, theMask, matchStep, hBoxSSize)
    n= size(im,1);
    
    c= 0;
    while( sum(sum(theMask))>50 && c<=1500 )%TODO
        c= c+1
 %       figure, imshow(im)
        E= edge(theMask, 'sobel');
        if( E==0 )%TODO
            disp('error');
        end
        IND= find(E);
        l= size(IND, 1);
        %l
        w= 0;
        for r=1:l
            w= w+1;
            [i,j]= myInd2Sub(n, IND(r));
            if( sum(sum( theMask(i-2:i+2,j-2:j+2) ))>0 )%TODO
                box= im(i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize, :);
                theMatch= findTheMatch2(im, theMask, box, matchStep, hBoxSSize);%TODO

                %blendTheMatch()
                im(i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize, :)= theMatch;
                theMask( i-hBoxSSize:i+hBoxSSize, j-hBoxSSize:j+hBoxSSize )=...
                theMatch(:,:,1)==0 &  theMatch(:,:,2)==0 & theMatch(:,:,3)==0;%TODO;
            end
        end
        
        theMask(E)= 0;
    end
    
end