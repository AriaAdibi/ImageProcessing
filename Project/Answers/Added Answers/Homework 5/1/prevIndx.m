function indx= prevIndx(indx, n)
    if( indx > 1 )
        indx= indx - 1;
    else
        indx= n;
    end
end