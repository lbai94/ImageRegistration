clear;
pic1=imread('1-2.jpg');
pic2=imread('2-2.jpg');
% 转为灰度图
pic1Gray=rgb2gray(pic1);
pic2Gray=rgb2gray(pic2);
% imshow(pic1Gray)
% figure;
% imshow(pic2Gray)
%均衡化
pic1Gray=histeq(pic1Gray);
pic2Gray=histeq(pic2Gray);
%中值滤波
pic1Gray=medfilt2(pic1Gray);
pic2Gray=medfilt2(pic2Gray);
%角点检测 Harris
corner1=Harris(pic1Gray);
corner2=Harris(pic2Gray);
%sift算子
 hog1=sift(pic1Gray,corner1);
 hog2=sift(pic2Gray,corner2);
%特征点匹配
[index1,index2]=match(hog1,hog2);
corner1=corner1(index1,:);
corner2=corner2(index2,:);
% x=corner1(:,1);
% y=corner1(:,2);
% figure;
% imshow(pic1Gray);
% hold on;
% plot(y,x,'g+');
% x=corner2(:,1);
% y=corner2(:,2);
% figure;
% imshow(pic2Gray);
% hold on;
% plot(y,x, 'g+');
 %显示匹配点  
    kongbai=ones(600,100,3);
    image=[pic1,kongbai,pic2];
    corner2(:,2)=corner2(:,2)+900;
    corner=[corner1;corner2];
    num=size(corner1,1);
    x=corner(:,1);
    y=corner(:,2);
    figure;
    imshow(image);
    hold on;
    plot(y,x, 'g+');
    
    for i=1:num
        hold on;
        line([y(i),y(i+num)],[x(i),x(i+num)]);
    end
    num=size(corner1,1);
    A=zeros(2*num,6);
    b=zeros(2*num,1);
    for i=1:num
        A(2*i-1,1:3)=[corner1(i,:),1];
        A(2*i,4:6)=[corner1(i,:),1];
        b(2*i-1:2*i)=corner2(i,:)';
    end
    m=(A'*A)\A'*b;
    rotate=[m(1),m(2),0;m(4),m(5),0;0,0,1];
    tform=maketform('affine',rotate);
    pic1=imtransform(pic1,tform);
    figure;
%     imshow(pic1);
%     row1=size(pic1,1);
%     col1=size(pic1,2);
%     row2=size(pic2,1);
%     col2=size(pic2,2);
%     f=ceil(m(3));
%     c=-ceil(m(6));
%      im(1:row2,1:col2,:)=pic2;
%      im(row2+1:row1+f,c+1:c+col1,:)=pic1(row2-f+1:row1,1:col1,:);
%      im(f+1:row2,col2+1:col1+c,:)=pic1(1:row2-f,col2-c+1:col1,:);
%      figure;
% %     im = uint8(im);
%      imshow(im);
% %     figure;
% %     imshow(pic2Gray);
% %     figure;
% %     imshow(pic1Gray);
