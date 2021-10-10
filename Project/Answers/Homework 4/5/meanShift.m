function P= meanShift(points, sigma, bandW, h, thresh)
    F= gKernelC(sigma, bandW);

    done= 0;
    P= points;
    copiedP= P;
    n= size(P, 1);

    while(~done)
        done= 1;

        for i=1:n
            p= copiedP(i,:);
            mean= 0;
            wTotal= 0;
            for j=1:n
                if(j~=i)
                    q= copiedP(j,:);
                    dis= eucDis(p,q);
                    if( dis<h )
                        dif= q-p;
                        r= ceil( abs(dif(1)) )+1;
                        s= ceil( abs(dif(2)) )+1;
                        
                        mean= mean+ F( r, s )*q;
                        wTotal= wTotal+ F( r, s );
                    end
                end
            end

            mean= mean/wTotal;
            meanShift= mean-p;
            if( abs(meanShift) > thresh )
                done= 0;
                p= mean;
                P(i,:)= p;
            end
        end
        
        copiedP= P;
    end

end

function F= gKernelC(sigma, bandW)
    F= zeros(bandW+1);

    for i= 0:bandW
        for j= 0:bandW
            F(i+1,j+1)= exp( -(eucDis(i,j)^2/(2*sigma^2*bandW^2)) );
        end
    end
end