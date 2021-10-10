function points= moveThePoints_v1(points, m, E_n, par, OO)
    n= size(points, 1);

    x= OO; y= OO;
    min= OO;
    for i=1:m
        for j=1:m
            if( E_n(i,j) < min )
                min= E_n(i,j);
                x= i; y=j;
            end
        end
    end
    
    %move the nth point
    points(n, :)= points(n, :) + [ (x-ceil(m/2)), (y-ceil(m/2)) ];
    %X= x
    %Y= y
    %move others
    for v=n-1:-1:1
        x= reshape(par(v+1, x, y, 1), [1,1]);
        y= reshape(par(v+1, x, y, 2), [1,1]);
        %if( x ~= X )
         %   dips('noproblem');
        %end
        points(v, :)= points(v, :) + [ (x-ceil(m/2)), (y-ceil(m/2)) ];
    end
end