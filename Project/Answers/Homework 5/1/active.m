function p = active(c, gradv, gradh)
    m = 9;
    gamma = 100;
    alpha = 0.01;
    E = zeros(size(c, 1), m ^ 2);
    par = zeros(size(c, 1), m ^ 2);
    for i = 1 : m^2
        E(1, i) = 0;
        par(1, i) = -1;
    end
   
    for i = 2 : size(c, 1)
        for j = 1 : m^2
            tmp = inf;
            par(i, j) = -1;
            [xthis, ythis] = point(c, i, j, m);
            for k = 1 : m^2
                [xpre, ypre] = point(c, i - 1, k, m);
                tmp_energy = E(i - 1, k) - gamma * grad(xthis, ythis, gradv, gradh) + alpha * dist(xthis, ythis, xpre, ypre);
                if tmp_energy < tmp
                    tmp = tmp_energy;
                    par(i, j) = k;
                end
            end
            E(i, j) = tmp;
        end
    end
    
    best = inf;
    indx = -1;
    for i = 1 : m^2
        if E(size(c, 1), i) < best
            best = E(size(c, 1), i);
            indx = i;
        end
    end
    
    xs = zeros(1, size(c, 1));
    ys = zeros(1, size(c, 1));
    for i = size(c, 1) : -1 : 1
        [x, y] = point(c, i, indx, m);
        xs(1, i) = x;
        ys(1, i) = y;
        indx = par(i, indx);
    end
    
    p = cat(1, xs, ys);
end

function [x, y] = point(c, i, j, m)
    j = j - 1;
    x = c(i, 1) + mod(j, m) - floor(m / 2);
    y = c(i, 2) + floor(wj / m) - floor(m / 2);
end

function grad = grad(x, y, gradv, gradh)
    grad = gradv(y, x) + gradh(y, x);
end

function dist = dist(x1, y1, x2, y2)
    dist = (x1 - x2) ^ 2 + (y1 - y2) ^ 2;
end