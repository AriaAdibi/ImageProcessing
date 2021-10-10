function [E_last, lastIndx, par]= dynamicPosEval_v4(points, st, Gmag, m, OO, alpha, gamma)
    nP= size(points, 1);
    nStates= m^2;
    E= zeros(nP, nStates) + OO;
    par= zeros(nP, nStates);
    
    %initialization
    for i=1:nStates
        E(st, i)= 0;
        par(st, i)= -1; %0 is also not valid but this is more robust
    end

    %dynamic iteration
    thisV= nextIndx(st, nP);
    prevV= st;
    for r=1:nP-1
        for i=1:nStates
            p= points(thisV,:);
            movedP= moveThePoint(p, i, m);
            for j=1:nStates
                %findTheEdgeVal
                q= points(prevV, :);
                movedQ= moveThePoint(q, j, m);
                e= gamma*(-( Gmag(movedP(1), movedP(2))^2 )) + alpha*sum( (movedP-movedQ).^2 );
                %evaluate E(v, i)
                if( E(prevV, j)+e < E(thisV, i) )
                    E(thisV, i)= E(prevV, j)+e;
                    par(thisV, i)= j;
                end
            end
        end
        prevV= thisV;
        thisV= nextIndx(thisV, nP);
    end
    
    lastIndx= prevIndx(thisV, nP);
    E_last= E(lastIndx, :);
end