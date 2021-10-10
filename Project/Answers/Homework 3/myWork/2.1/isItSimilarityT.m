%It is AffineT.
function [isSimilarityT, theta, a, b]= isItSimilarityT(M, tolerance)
    tanTh= M(2,1)/M(1,1);
    %{
    disp('WTF');%TODO
    disp(vpa(tanTh));
    %}
    theta= atan( tanTh );
    cosTh= cos(theta);  sinTh= sin(theta);
    
    isSimilarityT= abs( M(1,1)/cosTh - M(2,1)/sinTh )<tolerance & ...
                  abs( (-M(1,2))/sinTh - M(2,2)/cosTh )<tolerance;
    if( isSimilarityT )
        a= M(1,1)/cosTh;
        b= M(2,2)/cosTh;
    else
        a= Inf;
        b= Inf;
    end
end