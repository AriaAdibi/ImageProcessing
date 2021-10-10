function out= iZigzagScan(in)
    %% Initialization
    totE= 64;
    num_rows= 8; num_cols= 8;
    
    out= zeros(num_rows, num_cols);
    cur_row= 1; cur_col= 1; cur_indx= 1;

    %% iScan
    out(1,1)= in(1);
    while cur_indx<=totE
        out(cur_row,cur_col)=in(cur_indx);
        cur_indx=cur_indx+1;
        
        if(cur_row==1 & mod(cur_row+cur_col,2)==0 & cur_col~=num_cols)
            cur_col=cur_col+1; 

        elseif(cur_row==num_rows & mod(cur_row+cur_col,2)~=0 & cur_col~=num_cols)
            cur_col=cur_col+1;

        elseif(cur_col==1 & mod(cur_row+cur_col,2)~=0 & cur_row~=num_rows)
            cur_row=cur_row+1;
        
        elseif(cur_col==num_cols & mod(cur_row+cur_col,2)==0 & cur_row~=num_rows)
            cur_row=cur_row+1;

        %move diagonally left down
        elseif(cur_col~=1 & cur_row~=num_rows & mod(cur_row+cur_col,2)~=0)
            cur_row=cur_row+1;
            cur_col=cur_col-1;

        %move diagonally right up
        elseif(cur_row~=1 & cur_col~=num_cols & mod(cur_row+cur_col,2)==0)
            cur_row=cur_row-1;
            cur_col=cur_col+1;
        end
    end
end