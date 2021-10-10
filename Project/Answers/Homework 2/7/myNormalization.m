function norm = myNormalization(A)
    norm= ( A - min(min(A)) ) ./ ( max(max(A)) - min(min(A)) );
end