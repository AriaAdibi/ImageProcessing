%% inputs & initializations
clear all; clc;
orgIm= imread('im020.jpg');
%% find correcponding points
pointsO= [
    444, 750, 1;
    2928, 1524, 1;
    1926, 2550, 1;
    1818, 3780, 1;
    906, 1830, 1;
    ];

pointsT1= [
    731, 1870, 1;
    2457, 2890, 1;
    2727, 5031, 1;
    2727, 5031, 1;
    %3559, 7325, 1;
    1733, 3847, 1;
    ];

pointsT2= [
    1307, 1625, 1;
    3914, 1449, 1;
    4774, 2715, 1;
    6480, 3819, 1;
    3140, 2421, 1;
    ];

pointsT3= [
    659, 827, 1;
    3383, 2110, 1;
    2675, 2932, 1;
    2957, 4143, 1;
    1441, 2007, 1;
    ];

pointsT4= [
    565, 710, 1;
    1942, 1212, 1;
    1635, 1787, 1;
    1691, 2379, 1;
    1064, 1470, 1;
    ];

pointsT= cat(3, pointsT1, pointsT2, pointsT3, pointsT4 );
%% which translation is it?
tolerance= 0.005;

nT= 1;%size( pointsT, 3 );
nPoints= 5;

for r=1:1:nT
    disp( sprintf('T%d:', r) );

    M= [];
    for i=1:1:nPoints-2
        for j=i+1:1:nPoints-1
            for k=j+1:1:nPoints
                cPsT= ( [pointsT(i,:,r); pointsT(j,:,r); pointsT(k,:,r) ] )';
                cPsO= ( [pointsO(i,:); pointsO(j,:); pointsO(k,:) ] )';
                
                M= cat(3, M, cPsT/cPsO );
            end
        end
    end
    
    %M= mean(M, 3);
    for i=1:1:size(M,3)
        disp( sprintf('i= %d', i) );
        m= M(:,:,i);
        types= '';
        if( isItAffineT(m, tolerance) )
            types= sprintf('%sAffine', types);
            [isSimilarityT, theta, a, b]= isItSimilarityT(m, tolerance);
            %
            disp( sprintf('theta= %f, a= %f, b= %f', theta, a, b) );%TODO
            %
            if( isSimilarityT )
                types= sprintf('%s, Similarity', types);
                if( isItEuclideanT(a, b, tolerance) )
                    types= sprintf('%s, Euclidean', types);
                    if( isItRotationT(m(1,3), m(2,3), tolerance) )
                        types= sprintf('%s, Rotation', types);
                    else
                        if( isItTranslationT(theta, tolerance) )
                            types= sprintf('%s, Translation', types);
                        end
                    end
                else
                    if( isItScaleT(m, tolerance) )
                        types= sprintf('%s, Scale', types);
                    end
                end
            else
                if( isItShearT(m, tolerance) )
                        types= sprintf('%s, Shear', types);
                end
            end
        else
            types= sprintf('%sProjective', types);
            m= m * (m(3,3)^(-1));
        end

        disp( sprintf('%s:', types) );
        disp(m);
        %
        disp( mean(M,3) );
        %imshow( imwarp( orgIm, projective2d(M) ) );
        %imwrite( imwarp( orgIm, projective2d(M) ), sprintf('%d.jpg',r) );
    end
end