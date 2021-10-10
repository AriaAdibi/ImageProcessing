function[bestDisP]= findBestDisPForL(A, B, a, step)
    bestScore= inf;
    bestDisP= [0, 0];

    for x= -a:step:a
        for y= -a:step:a
            theScore= evalMatchScore(A, B, [x,y]);
            if bestScore > theScore
                bestScore= theScore;
                bestDisP= [x,y];
            end
        end
    end
    
end