%disP < -+20 & A >= B in dimentions & size(B)>20 & A is 2D but B can be 3D
function[theScore]= evalMatchScore(A, B, disP)
    iSecA= A( max([1, 1+disP(1)]) : min([end, size(B,1)+disP(1)]), ...
              max([1, 1+disP(2)]) : min([end, size(B,2)+disP(2)]) );
                  
    iSecB= B(max([1, 1-disP(1)]) : min( [end, end-(disP(1)-(size(A,1)-size(B,1)))] ), ...
             max([1, 1-disP(2)]) : min( [end, end-(disP(2)-(size(A,2)-size(B,2)))]), : );
    
    if size(iSecA, 1)~=size(iSecB, 1)
        disp('ERROR1');
    end
    if size(iSecA, 2)~=size(iSecB, 2)
        disp('ERROR2');
    end
    
    %optimizing %TODO
    pSizeIA= prod(size(iSecA));
    if pSizeIA >= 32000000 
        iSecA= imresize(iSecA, 1/1024, 'nearest');
        iSecB= imresize(iSecB, 1/1024, 'nearest');
    else
        if pSizeIA >= 16000000
        iSecA= imresize(iSecA, 1/512, 'nearest');
        iSecB= imresize(iSecB, 1/512, 'nearest');
        else
            if pSizeIA >= 8000000
            iSecA= imresize(iSecA, 1/256, 'nearest');
            iSecB= imresize(iSecB, 1/256, 'nearest');
            else
                if pSizeIA >= 4000000
                iSecA= imresize(iSecA, 1/128, 'nearest');
                iSecB= imresize(iSecB, 1/128, 'nearest');
                else
                    if pSizeIA >= 2000000
                    iSecA= imresize(iSecA, 1/64, 'nearest');
                    iSecB= imresize(iSecB, 1/64, 'nearest');
                    else
                        if pSizeIA >= 1000000
                        iSecA= imresize(iSecA, 1/32, 'nearest');
                        iSecB= imresize(iSecB, 1/32, 'nearest');
                        else
                            if pSizeIA >= 500000
                            iSecA= imresize(iSecA, 1/16, 'nearest');
                            iSecB= imresize(iSecB, 1/16, 'nearest');
                            else
                                if pSizeIA >= 100000
                                    iSecA= imresize(iSecA, 1/8, 'nearest');
                                    iSecB= imresize(iSecB, 1/8, 'nearest');
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    theScore= 0;
    for k=1:size(B,3)
        iMedC= (iSecA-iSecB(:,:,k)).^2; %TODO
        theScore= theScore + sum(sum(iMedC))/pSizeIA;
    end
end