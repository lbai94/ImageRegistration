function corner = Harris( image )
    im=double(image);
    nRow=size(im,1);
    nCol=size(im,2);
    [Ix,Iy]=gradient(im);
    f=zeros(nRow,nCol);
    result=zeros(nRow,nCol);
    for i=9:(nRow-8)
        for j=8:(nCol-8)
            H=zeros(2,2);
%             3*3´°¿Ú ¼ÆËãH
            for m=-2:2
                for n=-2:2
                    H=H+[Ix(i+m,j+n)*Ix(i+m,j+n),Ix(i+m,j+n)*Iy(i+m,j+n);Ix(i+m,j+n)*Iy(i+m,j+n),Iy(i+m,j+n)*Iy(i+m,j+n)];
                end
            end 
            f(i,j)=(H(1,1)*H(2,2)-H(1,2)*H(2,1))/(H(1,1)+H(2,2));
        end
        i
    end
    fMax=max(max(f));
    t=0.4*fMax;
    k=1;
    for i=8:(nRow-8)
        for j=8:(nCol-8)
            if(f(i,j)>=t)
              if (f(i, j) > f(i-1, j-1) && f(i, j) > f(i-1, j) && f(i, j) > f(i-1, j+1) && f(i, j) > f(i, j-1) && ...
                f(i, j) > f(i, j+1) && f(i, j) > f(i+1, j-1) && f(i, j) > f(i+1, j) && f(i, j) > f(i+1, j+1))
                result(i,j)=1;
                corner(k,1)=i;
                corner(k,2)=j;
                k=k+1;
              end
            end
        end
    end
    [posc, posr] = find(result == 1);
    figure;
    imshow(image);
    hold on;
    plot(posr, posc, 'g+');
end

