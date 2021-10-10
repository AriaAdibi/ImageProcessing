%It is EuclideanT.
function [isRotationT]= isItRotationT(t_x, t_y, tolerance)
    isRotationT= abs( t_x - 0 )<tolerance & abs( t_y - 0 )<tolerance;
end