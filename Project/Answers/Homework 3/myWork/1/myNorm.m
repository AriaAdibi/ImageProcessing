function A= myNorm(A)
    A= A- min( A(:) );
    A= A./max( A(:) );
end