%% inputs and initializations
clear all; clc;
orgIm= imread('im020.jpg');

%% find Ts
M_T1= findT1();
M_T2= findT2();
M_T3= findT3();
M_T4= findT4();

%% outputs
disp('T1:');
disp('Similarity:');
disp(M_T1);
tForm_T1= affine2d(M_T1');
imwrite( imwarp(orgIm, tForm_T1), 'T1_myGuess.jpg' );

disp('T2:');
disp('Affine:');
disp(M_T2);
tForm_T2= affine2d(M_T2');
imwrite( imwarp(orgIm, tForm_T2), 'T2_myGuess.jpg' );

disp('T3:');
disp('Affine:');
disp(M_T3);
tForm_T3= affine2d(M_T3');
imwrite( imwarp(orgIm, tForm_T3), 'T3_myGuess.jpg' );

disp('T4:');
disp('Projective:');
disp(M_T4);
tForm_T4= projective2d(M_T4');
imwrite( imwarp(orgIm, tForm_T4), 'T4_myGuess.jpg' );