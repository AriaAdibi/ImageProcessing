function [B, G, R] = getRGB(Im)
    B= Im(1:end/3, :);
    G= Im((end/3+1):(2*end/3), :);
    R= Im((2*end/3+1):end, :);
end