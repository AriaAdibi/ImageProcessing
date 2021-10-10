%------------------------------
% Gaussian Pyramid
% WONG WAY TO DO IT
% by Marco Zennaro
%------------------------------

%----------------------------------------------------------------------
% IMPORTANT NOTE: Do NOT use this code for downsize an image since
% this code does NOT deal with aliasing. Please use the gaussianPiramid
% function instead! This function is just useful to show some examples
% of aliasing
%----------------------------------------------------------------------


%-------------------------------------------
function [RI] = naiveGaussianPiramid(ImgName, ReductionFactor)
%-------------------------------------------
% NOTE: This function works with grayscale pictures
% This fuction takes an image and reduce it as described by the Reduction factor.
% It does NOT apply a gaussian filter before the sampling. This may lead to aliasing.
% The meaning of the parameters is the following:
% ImgName .......... Name of the picture file, complete with extension, RGB
% ReductionFactor .. reduction in size as power of two (e.g. 2 reduce the image
%                     to 1/4 of the original picture ).

% read the Original Image (OI)
OI = imread(ImgName);
SIZEOI = size(OI);

%compute the reduction factor
RF = pow2(ReductionFactor); 

% compute the new size
SIZERI = SIZEOI;
SIZERI(1) = SIZERI(1)/RF;
SIZERI(2) = SIZERI(2)/RF;

% create the reduce image through sampling
for i=1:1:SIZERI(1)
	for j=1:1:SIZERI(2)
			RI(i,j) = OI(i*RF,j*RF);
	end;
end;

imshow(RI);