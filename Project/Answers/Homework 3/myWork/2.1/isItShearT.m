%It is AffineT.
function [isShearT]= isItShearT(M, tolerance)
    isShearT= abs( M(1,1) - 1 )<tolerance & abs( M(2,2) - 1 )<tolerance & ...
                abs( M(1,3) - 0 )<tolerance & abs( M(2,3) - 0 )<tolerance;
end