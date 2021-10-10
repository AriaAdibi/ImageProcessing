tic
im= fillTheHole(im, theMask, 5, 5, 15);
toc
tic
theMask= im(:,:,1)==0 & im(:,:,2)==0 & im(:,:,3)==0;
im= fillTheHole(im, theMask, 1, 1, 3);
toc
%{
rdcdIm= im;
rdcdMask= theMask;
for i=1:redFac
    rdcdIm= imgaussfilt(rdcdIm, 1, 'FilterSize', 3, 'Padding', 'symmetric');
    rdcdIm= imresize(rdcdIm, 0.5, 'nearest');
    rdcdMask= imresize(rdcdMask, 0.5, 'nearest');
end
tic;
step= 1;
for i=1:redFac
    rdcdIm= fillTheHole(rdcdIm, rdcdMask, step, step, hBoxSSize);
    rdcdIm= imresize(rdcdIm, 2, 'bicubic');
    rdcdMask= imresize(rdcdMask, 2, 'bicubic');
    step= step*2;
end
toc;
%}
%{
tic;
[im, theMask]= fillTheHole(im, theMask, 5, 5, 15);
toc;
%%
tic;
theMask= im(:,:,1)==0 & im(:,:,2)==0 & im(:,:,3)==0;
[im, theMask]= fillTheHole(im, theMask, 3, 3, 10);
toc;
%%
tic;
theMask= im(:,:,1)==0 & im(:,:,2)==0 & im(:,:,3)==0;
[im, theMask]= fillTheHole(im, theMask, 2, 2, 6);
toc;
%%
tic;
theMask= im(:,:,1)==0 & im(:,:,2)==0 & im(:,:,3)==0;
[im, theMask]= fillTheHole(im, theMask, 1, 1, 3);
toc;
%}