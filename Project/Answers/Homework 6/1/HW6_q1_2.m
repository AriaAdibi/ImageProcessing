tic
I1 = imread('../inputs/man1.jpg');
I2 = imread('../inputs/man2.jpg');



c= size(I1, 2);
r= size(I1, 1);
ch=0;
I2= imresize(I2, [r, c]);

image1p = [1,1;
736,1;
1,763;
736,763;
315,123;
327,564;
195,380;
477,348;
242,371;
290,368;
347,365;
402,357;
315,359;
320,440;
285,422;
354,417;
275,476;
378,468;
186,224;
474,227;
435,494;
240,521;
222,350;
290,347;
336,344;
410,329;
447,438;
218,456;
326,501;
323,209];

       
image2p = [1,1;
           736,1;
           1,763;
           736,763;
           290,164;
348,567;
201,411;
473,336;
225,395;
278,380;
327,371;
383,356;
293,369;
306,435;
272,426;
342,411;
276,483;
374,461;
174,294;
408,251;
444,474;
264,533;
206,366;
278,356;
308,344;
384,323;
464,434;
227,488;
344,567;
275,227];



ave1= zeros(r, c, 3);
ave2= zeros(r, c, 3);
TRI = delaunay(image1p(:, 1),image1p(:, 2));

n= size(TRI, 1);

transList1= zeros(9, n);
transList2= zeros(9, n);
num=1;
result= zeros(r, c, 3, 7);
result(:, :, :, 1)= I1;
result(:, :, :, 18)= I2;

for s= 0.05: 0.05: 0.95
morphedPoints= (1-s)*image1p+ s*image2p;


for i= 1:n
    %find the corresponding triangle for mesh 1
%    i1=triangleSearch(TRI(i, :), TRI);
   %get transformation from image1 to ave
   source1= [image1p(TRI(i, 1), 1), image1p(TRI(i, 1), 2);
            image1p(TRI(i, 2), 1), image1p(TRI(i, 2), 2);
            image1p(TRI(i, 3), 1), image1p(TRI(i, 3), 2)];
    dest1= [morphedPoints(TRI(i, 1), 1), morphedPoints(TRI(i, 1), 2);
           morphedPoints(TRI(i, 2), 1), morphedPoints(TRI(i, 2), 2); 
           morphedPoints(TRI(i, 3), 1), morphedPoints(TRI(i, 3), 2)];
            t  = getTransformation(source1, dest1);

            translist1(:, i) = t(:);
                disp('');
    %find the corresponding triangle for mesh 2
%        i2=triangleSearch(TRI(i, :), TRI);
   %get transformation from image2 to ave
   source2= [image2p(TRI(i, 1), 1), image2p(TRI(i, 1), 2);
            image2p(TRI(i, 2), 1), image2p(TRI(i, 2), 2);
            image2p(TRI(i, 3), 1), image2p(TRI(i, 3), 2)];
    dest2= [morphedPoints(TRI(i, 1), 1), morphedPoints(TRI(i, 1), 2);
           morphedPoints(TRI(i, 2), 1), morphedPoints(TRI(i, 2), 2); 
           morphedPoints(TRI(i, 3), 1), morphedPoints(TRI(i, 3), 2)];
            t  = getTransformation(source2, dest2);
            translist2(:, i) = t(:);









            
end



% to see each point is in which triangle
map_points= [repmat(1:r, 1, c); reshape(repmat(1:c, r, 1), [1 r*c]); zeros(1, r*c)];
map_points= map_points';
map_points(:, 3)= trisearch(TRI,morphedPoints(:, 1), morphedPoints(:, 2), map_points(:, 1), map_points(:, 2));
%apply transformation
for i= 1: n
    sub_mat= map_points(map_points(:, 3)== i, :);
    mat= zeros(size(sub_mat, 1), 3);
    mat(:, 1)= sub_mat(:, 1);
    mat(:, 2)= sub_mat(:, 2);
    mat(:, 3)= 1;
    
    % for I1
    Tform= translist1(:, i);   
        Tform= [Tform(1) Tform(2) Tform(3); 
                Tform(4) Tform(5) Tform(6);
                Tform(7) Tform(8) Tform(9)];
        sol= inv(Tform)' *mat';
        solx = sol(1, :);
         solx(solx(1, :)<1)=1;
         solx(solx(1, :)>r)=r;

         soly= sol(2, :);
         soly(soly(1, :)<1)=1;
         soly(soly(1, :)>c)=c;
          mat1= mat(:, 1);
           mat2= mat(:, 2);
           x= ceil(solx');
           y= ceil(soly');

           ind1= sub2ind(size(I1), x', y', ones(1, size(mat1, 1))); 
           ind2= sub2ind(size(I1), x', y', ones(1, size(mat1, 1))+1);
           ind3= sub2ind(size(I1), x', y', ones(1, size(mat1, 1))+2);
           Ind1= sub2ind(size(ave1), mat1', mat2', ones(1, size(mat1, 1)));
           Ind2= sub2ind(size(ave1), mat1', mat2', ones(1, size(mat1, 1))+1);
           Ind3= sub2ind(size(ave1), mat1', mat2', ones(1, size(mat1, 1))+2);
           ave1(Ind1)= I1(ind1);
           ave1(Ind2)= I1(ind2);
           ave1(Ind3)= I1(ind3);

        
        
        %for I2
        
        Tform= translist2(:, i);   
        Tform= [Tform(1) Tform(2) Tform(3); 
                Tform(4) Tform(5) Tform(6);
                Tform(7) Tform(8) Tform(9)];
         sol= inv(Tform)' *mat';
         solx= sol(1, :);
         soly= sol(2, :);
          solx(solx(1, :)<1)=1;
         soly(soly(1, :)<1)=1;
          solx(solx(1, :)>r)=r;
          soly(soly(1, :)>c)=c;
           mat1= mat(:, 1);
           mat2= mat(:, 2);
           x= ceil(solx');
           y= ceil(soly');
           ind1= sub2ind(size(I2), x', y', ones(1, size(mat1, 1))); 
           ind2= sub2ind(size(I2), x', y', ones(1, size(mat1, 1))+1);
           ind3= sub2ind(size(I2), x', y', ones(1, size(mat1, 1))+2);
           Ind1= sub2ind(size(ave2), mat1', mat2', ones(1, size(mat1, 1)));
           Ind2= sub2ind(size(ave2), mat1', mat2', ones(1, size(mat1, 1))+1);
           Ind3= sub2ind(size(ave2), mat1', mat2', ones(1, size(mat1, 1))+2);
           ave2(Ind1)= I2(ind1);
           ave2(Ind2)= I2(ind2);
           ave2(Ind3)= I2(ind3);


        
      
        
    
end
   
 ave1= imresize(ave1, [size(ave2, 1), size(ave2, 2)]);
 res= (1-s)*ave1+ s*ave2;
%  imshow(uint8(res));
 num= num+1;
 result(:, :, :, num)= uint8(res);
end
frame2gif(uint8(result),'result.gif',0.2,1,size(result,1));
toc
