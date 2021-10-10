function [x,y]=  myInd2Sub(n, indx)
    y= floor(indx/n)+1;
    x= indx-(y-1)*n;
end