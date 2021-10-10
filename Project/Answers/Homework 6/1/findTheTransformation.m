function [T1, T2]= findTheTransformation(cPoints1, cPoints2, avgCPoints, TRI)
    nT= size(TRI, 1);
    T1= cell(1, nT);
    T2= cell(1, nT);
    
    for i=1:nT
        p1= TRI(i, 1);  p2= TRI(i,2);  p3= TRI(i,3);
        T1{i}= estimateGeometricTransform([cPoints1(p1,:);cPoints1(p2,:);cPoints1(p3,:);], ...
                        [avgCPoints(p1,:);avgCPoints(p2,:);avgCPoints(p3,:);], 'similarity');
        T2{i}= estimateGeometricTransform([cPoints2(p1,:);cPoints2(p2,:);cPoints2(p3,:);], ...
                        [avgCPoints(p1,:);avgCPoints(p2,:);avgCPoints(p3,:);], 'similarity');
    end
end