function indx= nextIndx(indx, n)
    if( indx ~= n )
        indx= indx + 1;
    else
        indx= 1;
    end
end