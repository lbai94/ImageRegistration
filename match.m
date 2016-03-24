function [index1,index2] = match(hog1,hog2 )
    tree = kd_buildtree(hog2,0);
    hog1Rows=size(hog1,1);
    d=zeros(1,hog1Rows);
    index2=zeros(1,hog1Rows);
    index1=linspace(1,hog1Rows,hog1Rows);
    for i=1:hog1Rows
        [index_vals,dist_vals,vec_vals]  = kd_knn(tree,hog1(i,:),2,0);
        d(i)=norm(hog1(i,:)-hog2(index_vals(1),:))/norm(hog1(i,:)-hog2(index_vals(2),:));
        index2(i)=index_vals(1);
    end
    t=2.5*min(d);
    index1=index1(d<t);
    index2=index2(d<t);
end

