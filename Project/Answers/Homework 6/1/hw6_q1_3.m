
I2 = imread('../inputs/man1.jpg');
I1 = imread('../inputs/man2.jpg');
%% corresponding points
figure,imshow(I1);
[x1,y1] = ginput(10);
figure,imshow(I2);
[x2,y2] = ginput(10);
points1 = zeros(size(x1,1),2);
points2 = zeros(size(x2,1),2);
points1(1,:)=[1,1];
points1(2,:)=[1,size(I1,2)];
points1(3,:)=[size(I1,1),1];
points1(4,:)=[size(I1,1),size(I1,2)];
for i = 1 : size(x1,1)
    points1(i+4,1) = x1(i);
    points1(i+4,2) = y1(i);
end
points2(1,:)=[1,1];
points2(2,:)=[1,size(I2,2)];
points2(3,:)=[size(I2,1),1];
points2(4,:)=[size(I2,1),size(I2,2)];
for i = 1 : size(x2,1)
    points2(i+4,1) = x2(i);
    points2(i+4,2) = y2(i);
end
%% triangulation 
%intermediate_shape = (I1+I2)/2;
points_i = (points1+points2)/2;
tri = delaunay(points_i(:,1),points_i(:,2));
%% 
for t = 0
    average_points= (1-t) * points1 + t* points2;
    resultImage=zeros(round(average_points(4,1)),round(average_points(4,2)),3);
    tri = delaunay(average_points(:,1),average_points(:,2));
    tform1=cell(1,size(tri,1));
    tform2=cell(1,size(tri,1));
    for i=1:size(tri,1)
        p1=tri(i,1);
        p2=tri(i,2);
        p3=tri(i,3);
        tform1{i}=estimateGeometricTransform([points1(p1,:);points1(p2,:);points1(p3,:)],[average_points(p1,:);average_points(p2,:);average_points(p3,:)],'affine');
        tform2{i}=estimateGeometricTransform([points2(p1,:);points2(p2,:);points2(p3,:)],[average_points(p1,:);average_points(p2,:);average_points(p3,:)],'affine');
    end
    res1=resultImage;
    res2=resultImage;
    tic
    for i=1:fix(average_points(4,1))
        for j=1:fix(average_points(4,2))
            triind=tsearchn(average_points,tri,[i,j]);
            [X1,Y1]=transformPointsInverse(tform1{triind},i,j);
            [X2,Y2]=transformPointsInverse(tform2{triind},i,j);
            resultImage(i,j,:)=(1-t)*I1(round(X1),round(Y1),:)+t*I2(round(X2),round(Y2),:);
            res1(i,j,:)=I1(round(X1),round(Y1),:);
            res2(i,j,:)=I2(round(X2),round(Y2),:);
        end
    end
    toc
    figure,imshow(uint8(resultImage));
    figure,imshow(uint8(res1));
    figure,imshow(uint8(res2));
end

