function points= moveThePoints_v2(points, m, E_n, par, OO)
    n= size(points, 1);
    nStates= m^2;
    
    min= OO;
    indx= -1;
    for i=1:nStates
        if( E_n(i) < min )
            min= E_n(i);
            indx= i;
        end
    end
    
    %move the nth point
    points(n, :)= moveThePoint(points(n,:), indx, m);
    %move others
    for v=n-1:-1:1
        indx= par(v+1, indx);
        points(v, :)= moveThePoint(points(v,:), indx, m);
    end
end