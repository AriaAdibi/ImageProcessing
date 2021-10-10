function out = zigzagScan(in) %in is square

    %% initialization
    imin = 1; jmin = 1;

    [imax, jmax]= size(in);

    indx = 1;
    out = zeros(1, imax * jmax);

    %% Scan
    i=1; j=1;
    while ((i <= imax) & (j <= jmax))
        out(indx) = in(i, j);
        indx= indx+1;
        
        %upward movement
        if (mod(i + j, 2) == 0)
            if(i == imin)       
                if(j == jmax)
                  i= i + 1;
                else
                  j= j + 1;
                end
                
            elseif(j == jmax)
                i= i + 1;
                
            else
                i= i - 1;
                j= j + 1;
            end
        %downward movement
        else                            
           if(i == imax)
                j= j + 1;

           elseif(j == jmin)
                if(i == imax)
                  j= j + 1;
                else
                  i= i + 1;
                end
                
           else
                i= i + 1;
                j= j - 1;
           end

        end
    end
    
end