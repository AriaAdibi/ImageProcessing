%It is SimilarityT.
function [isEuclideanT]= isItEuclideanT(a, b, tolerance)
    isEuclideanT= abs( a-1 )<tolerance & abs( b-1 )<tolerance;
end