function points= moveThePoints_v3(points, m, E_last, lastIndx, par, OO)
    n= size(points, 1);
    nStates= m^2;
    
    min= OO;
    indx= -1;
    for i=1:nStates
        if( E_last(i) < min )
            min= E_last(i);
            indx= i;
        end
    end
    
    %move the nth point
    points(lastIndx, :)= moveThePoint(points(lastIndx,:), indx, m);
    %move others
    thisV= lastIndx;
    for r=1:n-1
        indx= par(thisV, indx);
        thisV= prevIndx(thisV, n);
        points(thisV, :)= moveThePoint(points(thisV,:), indx, m);
    end
end