clear; clc;
close all;

I = rgb2gray(im2double(imread('../inputs/tasbih.jpg')));
gradv = imfilter(I, [1 -1], 'same') .^ 2;
gradh = imfilter(I, [1; -1], 'same') .^ 2;

figure; imshow(I);
m = roipoly;

c = bwboundaries(m);
c = c{1}(1:10:end, :);
c = c(:, [2 1]);

hold on;
plot(c(:, 1), c(:, 2));
%%
for i = 1 : 20
    p = active(c, gradv, gradh);
    for j = 1 : size(c, 1)
        c(j, 1) = p(1, j);
        c(j, 2) = p(2, j);
    end
end

hold on;
plot(c(:, 1), c(:, 2));