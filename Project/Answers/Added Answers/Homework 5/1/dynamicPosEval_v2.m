function [E_n, par]= dynamicPosEval_v2(points, Gmag, m, OO, alpha, gamma)
    nP= size(points, 1);
    nStates= m^2;
    E= zeros(nP, nStates) + OO;
    par= zeros(nP, nStates);
    
    %initialization
    for i=1:nStates
        E(1, i)= 0;
        par(1, i)= -1; %0 is also not valid but this is more robust
    end

    %dynamic iteration
    for v=2:nP
        for i=1:nStates
            p= points(v,:);
            movedP= moveThePoint(p, i, m);
            for j=1:nStates
                %findTheEdgeVal
                q= points(v-1,:);
                movedQ= moveThePoint(q, j, m);
                e= gamma*(-( Gmag(movedP(1), movedP(2))^2 )) + alpha*sum( (movedP-movedQ).^2 );
                %evaluate E(v, i)
                if( E(v-1, j)+e < E(v, i) )
                    E(v, i)= E(v-1, j)+e;
                    par(v, i)= j;
                end
            end
        end
    end
    
    E_n= E(nP, :);
end