%It is SimilarityT.
function [isScaleT]= isItScaleT(M, tolerance)
    isScaleT= abs( M(1,2) - 0 )<tolerance & abs( M(2,1) - 0 )<tolerance & ...
              abs( M(1,3) - 0 )<tolerance & abs( M(2,3) - 0 )<tolerance;
end