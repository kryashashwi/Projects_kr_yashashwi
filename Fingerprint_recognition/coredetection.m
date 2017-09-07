function []=coredetection(Ip1,Ip2)
%Ip1=im2double(imread('F:\moodle\sem5\CS663 Digital Image Processing\project\database\107_4.tif'));
Inp2=whitespaceremove(Ip2);
Inp1=whitespaceremove(Ip1);
[row1 col1,absimg1]=complexNew(Inp1,1,25);%m %sig
% figure();
% imshow(Inp1);
figure();
imshow(absimg1,[min(absimg1(:)), max(absimg1(:))]);
hold on;
scatter(col1,row1,190);
figure();
imshow(Inp1);
hold on;
scatter(col1,row1,190)

[row2 col2,absimg2]=complexNew(Inp2,1,25);%m %sig
figure();
imshow(absimg2,[min(absimg2(:)), max(absimg2(:))]);
hold on;
scatter(col2,row2,190);
figure();
imshow(Inp2);
hold on;
scatter(col2,row2,190)

end