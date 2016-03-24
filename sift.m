function hog=sift(image,corner)
    im=double(image);
    cornerNum=size(corner,1);
    hog=zeros(cornerNum,128);
    for i=1:cornerNum
        x=corner(i,1);
        y=corner(i,2);
        window=im((x-7):(x+8),(y-7):(y+8));
        [Ix,Iy]=gradient(window);
        gradMag=sqrt(Ix.^2+Iy.^2);
        gradAng=((atan2(Iy,Ix)+pi).*180)./pi;
        gradOrient=ceil(gradAng./45);%consider 8 directions
        GrandH=zeros(1,8);
        for j=1:4
            for k=1:4
                subGradMag=gradMag((j*4-3):j*4,(k*4-3):k*4);
                subGradOrient=gradOrient((j*4-3):j*4,(k*4-3):k*4);
                for m=1:8
                    GrandH(m)=sum(subGradMag(subGradOrient==m));
                end
                hog(i,(j-1)*32+k*8-7:(j-1)*32+k*8)=GrandH;
            end
        end
        hog(i,:)=mapminmax(hog(i,:));
    end
end