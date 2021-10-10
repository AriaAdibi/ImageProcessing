%It is EuclideanT.
function [isTranslationT]= isItTranslationT(theta, tolerance)
    isTranslationT= abs( theta - 0 )<tolerance;
end