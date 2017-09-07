%function [a,rfgabs]=fingerprintmatching(Inp1,Inp2)
Inp1=im2double(imread('F:\moodle\sem5\CS663 Digital Image Processing\project\database\101_7.tif'));
[row1 col1,absimg1]=complexNew(Inp1,2,18);
fmatchscore=zeros(8,4);

%for kk=1:9
for zz=1:8
%Inp2=0;
Inp2=im2double(imread(strcat('F:\moodle\sem5\CS663 Digital Image Processing\project\database\10',num2str(kk),'_',num2str(zz),'.tif')));

%%%INITIALIZIATION%%%%%%%%%
%I1=0;I2=0;TT=0;im2=0;rotatedimg=0;I1new=0;I2new=0;matchingscore=0;absimg2=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%displacement align
[row2 col2,absimg2]=complexNew(Inp2,2,18);
I2=ones(size(Inp1,1)*3,size(Inp1,2)*3);
I1=ones(size(Inp1,1)*3,size(Inp1,2)*3);
I1(size(Inp1,1)+1:2*size(Inp1,1),size(Inp1,2)+1:2*size(Inp1,2))=Inp1;
I2(size(Inp2,1)+1:2*size(Inp2,1),size(Inp2,2)+1:2*size(Inp2,2))=Inp2;
[row1 col1,absimg1]=complexNew(I1,2,18);
[row2 col2,absimg2]=complexNew(I2,2,18);
im2 = circshift(I2, [row1-row2 col1-col2]);
[row2k col2k]=complexNew(im2,2,18);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%rotation align
theta=-10:10;
matchingscore=zeros(length(theta),1);
I1c=imcomplement(I1);
 for i=1:length(theta)
     rotatedimg= rotateAround(imcomplement(im2),row2k, col2k , theta(i), 'bicubic');
     matchingscore(i)=BLPOC(I1c,rotatedimg);
 end
[M,index]=max(matchingscore);
% fmatchscore(8*(kk-1)+zz,1)=theta(index);
% fmatchscore(8*(kk-1)+zz,2)=M;
I2aligned=rotateAround(imcomplement(im2),row2k, col2k , theta(index), 'bicubic');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Common region extraction
TT=imcomplement(I1).*I2aligned;
[it,w3,w4,w1,w2]=whitespaceremove(imcomplement(TT));
I1new=I1(w3:w4,w1:w2);
I2new=I2aligned(w3:w4,w1:w2);
[row1new col1new]=complexNew(I1new,2,18);
[row2new col2new]=complexNew(I2new,2,18);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Matching
[a,rfgabs]=BLPOC(imcomplement(I1new),I2new);

% fmatchscore(8*(kk-1)+zz,3)=a;
% if(a>=0.15 && kk==1)
%     fmatchscore(8*(kk-1)+zz,4)=1; %MATCH
% end
% if(a<0.15 && kk==1)
%     fmatchscore(8*(kk-1)+zz,4)=-1; %FALSE NEGATIVE
% end
% if(a>=0.15 && kk~=1)
%     fmatchscore(8*(kk-1)+zz,4)=2; %FALSE POSITIVE
% end

% subplot(4,2,zz);
% surf(abs(rfgabs),'FaceColor','black','EdgeColor','none','FaceAlpha',0.4);
% camlight left; lighting phong;
% title(['102-',num2str(zz)]);
%end
end
%end















