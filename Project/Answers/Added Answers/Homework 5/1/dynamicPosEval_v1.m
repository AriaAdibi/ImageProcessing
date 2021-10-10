function [E_n, par]= dynamicPosEval_v1(points, Gmag, m, OO, alpha, gamma)
    nP= size(points, 1);
    E= zeros(nP, m, m) + OO;
    par= zeros(nP, m, m, 2);

    %initialization
    for i=1:m
        for j=1:m
            E(1, i, j)= 0;
            par(1, i, j, :)= -1; %0 is also not valid but this is more robust
        end
    end

    %dynamic iteration
    for v=2:nP
        for i=1:m
            for j=1:m
                p= points(v,:);
                movedP= p + [ (i-ceil(m/2)), (j-ceil(m/2)) ];
                for r=1:m
                    for s=1:m
                        %findTheEdgeVal
                        q= points(v-1,:);
                        movedQ= q + [ (r-ceil(m/2)), (s-ceil(m/2)) ];
                        e= gamma*(-( Gmag(movedP(1), movedP(2))^2 )) + alpha*sum( (movedP-movedQ).^2 );
                        %evaluate E(v, i, j)
                        if( E(v-1, r, s)+e < E(v,i,j) )
                            E(v, i, j)= E(v-1, r, s)+e;
                            par(v, i, j, 1)= r;
                            par(v, i, j, 2)= s;
                        end
                    end
                end
            end
        end
    end
    
    E_n= reshape(E(nP, :, :), [m, m]);
end