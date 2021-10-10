function p= moveThePoint(p, indx, m)
    indx= indx-1;
    %The indx is 0 base now
    x= floor(indx/m) + 1;
    y= mod(indx, m) + 1;
    dx= x - ceil(m/2);
    dy= y - ceil(m/2);
    
    p= p + [dx, dy];
end