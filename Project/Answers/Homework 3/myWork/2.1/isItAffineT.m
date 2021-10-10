function [isAffineT]= isItAffinT( M, tolerance )
    isAffineT= abs( M(3,1)-0 )<tolerance & abs( M(3,2)-0 )<tolerance &...
               abs( M(3,3)-1 )<tolerance;
end