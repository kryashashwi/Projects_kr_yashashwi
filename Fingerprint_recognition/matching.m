%Inp1=im2double(imread('F:\moodle\sem5\CS663 Digital Image Processing\project\database\108_3.tif'));
Inp1=im2double(imread('.\database\106_8.tif'));
%Inp1=imresize(Ip1,0.5);
[row1 col1,absimg1]=complexNew(Inp1,2,18);

fmatchscore=zeros(8,3);
% figure();
% imshow(absimg1,[min(absimg1(:)), max(absimg1(:))]);
% hold on;
% scatter(col1,row1);
% figure();
% imshow(Inp1);
% hold on;
% scatter(col1,row1);
% [img1]=whitespaceremove(Inp1);
for zz=1:8
Inp2=0;
%Inp2=im2double(imread(strcat('F:\moodle\sem5\CS663 Digital Image Processing\project\database\108_',num2str(zz),'.tif')));
Inp2=im2double(imread(strcat('.\database\106_',num2str(zz),'.tif')));
%Inp2=Inp1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%INITIALIZIATION%%%%%%%%%
I1=0;I2=0;TT=0;im2=0;rotatedimg=0;I1new=0;I2new=0;matchingscore=0;absimg2=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [img2]=whitespaceremove(Inp2);
% [X1, Y1]=meshgrid( linspace(0, 1, size(img1,2)), linspace(0, 1, size(img1,1)));
% [X2, Y2]=meshgrid( linspace(0, 1, size(img2,2)), linspace(0, 1, size(img2,1)));
% nchannels = size(img1,3);
% % interpolate each color plane separately
% for k=1:nchannels
%   scaledI2(:,:,k)=interp2(X2, Y2, double(img2(:,:,k)), X1, Y1); 
% end
% Img2=scaledI2;
% Img1=img1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[row1 col1,absimg1]=complexNew(Inp1,2,18);
[row2 col2,absimg2]=complexNew(Inp2,2,18);
% figure();
% imshow(absimg1,[min(absimg1(:)), max(absimg1(:))]);
% hold on;
% scatter(col1,row1);
% figure();
% imshow(Inp1);
% hold on;
% scatter(col1,row1);
%%-----------
% figure();
% imshow(Inp2);
% hold on;
% scatter(col2,row2);
% figure();
% imshow(absimg2,[min(absimg2(:)), max(absimg2(:))]);
% hold on;
% scatter(col2,row2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%displacement align
I2=ones(size(Inp1,1)*3,size(Inp1,2)*3);
I1=ones(size(Inp1,1)*3,size(Inp1,2)*3);
I1(size(Inp1,1)+1:2*size(Inp1,1),size(Inp1,2)+1:2*size(Inp1,2))=Inp1;
I2(size(Inp2,1)+1:2*size(Inp2,1),size(Inp2,2)+1:2*size(Inp2,2))=Inp2;
[row1 col1,absimg1]=complexNew(I1,2,18);
[row2 col2,absimg2]=complexNew(I2,2,18);
im2 = circshift(I2, [row1-row2 col1-col2]);
[row2k col2k]=complexNew(im2,2,18);
% imagesc(I1);
%  hold on;
%  scatter(col1,row1,90,[0 1 0],'filled','^');
% figure();
% imagesc(im2);
%  hold on;
%  scatter(col2k,row2k,90,[0 1 0],'filled','^');
% figure();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%rotation align
theta=-10:10;
matchingscore=zeros(length(theta),1);
I1c=imcomplement(I1);
%mask = true(size(im2));
for i=1:length(theta)
  %  rotatedimg=imrotate(im2,theta(i),'bicubic');
    
   rotatedimg= rotateAround(imcomplement(im2),row2k, col2k , theta(i), 'bicubic');
%     rotatedimg(1:size(Inp2,1),1:size(Inp2,2))=1;
%     rotatedimg(1:size(Inp2,1),2*size(Inp2,2)+1:size(im2,2))=1;
%     rotatedimg(2*size(Inp2,2)+1:size(im2,1),1:size(Inp2,2))=1;
%     rotatedimg(2*size(Inp2,2)+1:size(im2,1),2*size(Inp2,2):size(im2,2))=1;
%     rotatedimg(1:round(size(rotatedimg,1)/10),1:size(rotatedimg,2))=1;%%upper line
%     rotatedimg(1:size(rotatedimg,1),(size(rotatedimg,2)-round(size(rotatedimg,2)/10)):size(rotatedimg,2))=1;
%     rotatedimg(1:size(rotatedimg,1),1:round(size(rotatedimg,2)/10))=1;%%right line
%     rotatedimg((size(rotatedimg,1)-round(size(rotatedimg,1)/10)):size(rotatedimg,1),1:size(rotatedimg,2))=1;%%bottom line
%imshow(rotatedimg)
    matchingscore(i)=BLPOC(I1c,rotatedimg);
%     figure();
%      imshow(rotatedimg);axis on;
%    title(num2str(theta(i)));
 %  maskR = ~imrotate(mask, theta(i), 'crop');
  % meanI = mean(im2(:));
  % rotatedimg(maskR) = meanI;
%  Mrot = ~imrotate(true(size(im2)),theta(i));
% rotatedimg(Mrot&~imclearborder(Mrot)) = 255;
end
% figure();
% imshow(rotatedimg);axis on;

[M,index]=max(matchingscore);
fmatchscore(zz,1)=theta(index);
fmatchscore(zz,2)=M;
I2aligned=rotateAround(imcomplement(im2),row2k, col2k , theta(index), 'bicubic');
% I2aligned(1:size(Inp2,1),1:size(Inp2,2))=ones(size(Inp2,1),size(Inp2,2));
%     I2aligned(1:size(Inp2,1),2*size(Inp2,2)+1:size(im2,2))=ones(size(Inp2,1),size(im2,2)-2*size(Inp2,2));
%     I2aligned(2*size(Inp2,2)+1:size(im2,1),1:size(Inp2,2))=ones(size(im2,1)-2*size(Inp2,2),size(Inp2,2)-1+1);
%     I2aligned(2*size(Inp2,2)+1:size(im2,1),2*size(Inp2,2):size(im2,2))=ones(size(im2,1)-2*size(Inp2,2)-1+1,size(im2,2)-2*size(Inp2,2)+1);
%    I2aligned(1:round(size(rotatedimg,1)/10),1:size(rotatedimg,2))=ones(round(size(rotatedimg,1)/10),size(rotatedimg,2));%%upper line
%     I2aligned(1:size(rotatedimg,1),(size(rotatedimg,2)-round(size(rotatedimg,2)/10)):size(rotatedimg,2))=ones(size(rotatedimg,1),size(rotatedimg,2)-(size(rotatedimg,2)-round(size(rotatedimg,2)/10))+1);
%     I2aligned(1:size(rotatedimg,1),1:round(size(rotatedimg,2)/10))=ones(size(rotatedimg,1),round(size(rotatedimg,2)/10));%%right line
%     I2aligned((size(rotatedimg,1)-round(size(rotatedimg,1)/10)):size(rotatedimg,1),1:size(rotatedimg,2))=ones(size(rotatedimg,1)-(size(rotatedimg,1)-round(size(rotatedimg,1)/10))+1,size(rotatedimg,2));%%bottom line
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Common region extraction
TT=imcomplement(I1).*I2aligned;
[it,w3,w4,w1,w2]=whitespaceremove(imcomplement(TT));
I1new=I1(w3:w4,w1:w2);
I2new=I2aligned(w3:w4,w1:w2);
[row1new col1new]=complexNew(I1new,2,18);
[row2new col2new]=complexNew(I2new,2,18);
[a,rfgabs,AbsOfRFG]=BLPOC(imcomplement(I1new),I2new);
%disp(a);
fmatchscore(zz,3)=a;

%figure();
%  subplot(4,2,zz);
% surf(abs(rfgabs),'FaceColor','black','EdgeColor','none','FaceAlpha',0.4);
%  camlight left; lighting phong;
%  title(['102-',num2str(zz)]);
% % imshow(I1new);axis on;
% % hold on
% % scatter(col1new,row1new);
% % figure();
% % imshow(I2new);axis on;
% % hold on
% % scatter(col2new,row2new);
end
ms=fmatchscore(:,3);
Matched=length(ms(ms>=0.10));
disp(Matched);














