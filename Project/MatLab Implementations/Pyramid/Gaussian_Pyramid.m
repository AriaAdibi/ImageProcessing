%------------------------------
% Gaussian Pyramid
% by Marco Zennaro
% http://www.zennaro.net
%------------------------------

%-------------------------------------------
function [RI] = gaussianPiramid(ImgName, ReductionFactor, KernelSize, Sigma)
%-------------------------------------------
% NOTE: This function works with grayscale pictures
% This fuction takes an image and reduce it as described by the Reduction factor.
% Before sampling the image is convolved witha  gaussian filter with standard
% deviation Sigma and size KernelSize
% The meaning of the parameters is the following:
% ImgName .......... Name of the picture file, complete with extension;
% ReductionFactor .. Reduction in size as power of two (e.g. 2 reduce the image
%                     to 1/4 of the original picture );
% Sigma ............ Standard deviation of the gaussian filter (used for AA)
% KernelSize ....... The size of the convolution Kernel we use to smooth before
%					 sampling

% read the Original Image (OI)
OI = imread(ImgName); 
RI = OI;
SIZERI = size(OI);

% Create the filter kernel
% (we implemented this routine, but the same kernel can be obtained
% using the function fspecial of Matlab)
k = gaussianKernel(KernelSize,Sigma);

for t=1:1:ReductionFactor
	% convolve it with the picture
	FI = RI;
	if t==1 FI = filter2(k,RI)/255; else FI = filter2(k,RI); end;
	
	% compute the size of the reduced image
	SIZERI(1) = SIZERI(1)/2;
	SIZERI(2) = SIZERI(2)/2;

	% create the reduced image through sampling
	RI = zeros(SIZERI(1),SIZERI(2));
	for i=1:1:SIZERI(1)
		for j=1:1:SIZERI(2)
			RI(i,j) = FI(i*2,j*2);
		end;
	end;
	
end; % t

imshow(RI);

%-------------------------------------------
function [K] = gaussianKernel(Size,SD)
%-------------------------------------------
% NOTE: This function create the convolution kernel
% Size .... Kernel Size
% SD ...... Standard Deviation
K = zeros(Size, Size);
tot = 0;
for i=1:1:Size
	for j=1:1:Size
		K(i,j) = exp(-((i-Size/2).^2+(j-Size/2).^2)/(2*SD.^2))/(2*pi*SD.^2);
		tot = tot + K(i,j);
	end;
end;
for i=1:1:Size
	for j=1:1:Size
		K(i,j) = K(i,j)/tot;
	end;
end;

%-------------------------------------------
function [RI] = naiveGaussianPiramid(ImgName, ReductionFactor)
%-------------------------------------------
% NOTE: This function works with RGB pictures
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
		for z=1:1:SIZERI(3)
			RI(i,j,z) = OI(i*RF,j*RF,z);
		end;
	end;
end;

imshow(RI);