I1=(imread('fielpath'));
I2=(imread('filepath'));
%disparityRange = [0,64];
%disparityMap = disparity(rgb2gray(I1),rgb2gray(I2),'BlockSize',...
 %figure
%imshow(disparityMap,disparityRange);
%title('Disparity Map');
%colormap jet
%colorbar

 I1=im2double(imread('F:\moodle\sem6\EE702_Computer_Vision\Art\1.jpg'));
 I2=im2double(imread('F:\moodle\sem6\EE702_Computer_Vision\Art\2.jpg'));
  imshow(im1)
 
 imm1=rgb2gray(I1);
 imm2=rgb2gray(I2);
 im1=imresize(imm1,0.08);
 im2=imresize(imm2,0.08);
 BW1 = edge(im1,'canny');
 BW2 = edge(im2,'canny');
 disparity=zeros(size(im1,1),size(im1,2));
 for i=5:size(im1,1)-5
     for j=5:size(im1,2)-5
             if(BW1(i,j)==1)
             im1Window = getNeighbourhoodWindow(im1, i ,j, 3);
             r=0;
             for p=j:size(im2,2)-15
                 im2Window = getNeighbourhoodWindow(im2, i ,p, 3);    
                 cc=xcorr2(im1Window,im2Window);
                 r(p)=max(cc(:));
                  r(p)=cc;
                 disp(r(p));
             end
             [val,ind]=max(r);    
             disparity(i,j)=ind-j;
             else
                 disparity(i,j)=0;  
             end
         if(disparity(i,j)<0)
             disparity(i,j)=0;
         end
     end
 end
 depth=zeros(size(disparity,1),size(disparity,2));
 % The focal length is 3740 pixels, and the baseline is 160mm
 baseline=604;
 f=3740;
 Num=f*baseline;
 for i=1:size(disparity,1)
     for j=1:size(disparity,2)
         if (disparity(i,j)~=0)
             depth(i,j)=Num/disparity(i,j);
         end
     end
 end
 depthmap=depth/max(depth(:));
 disparitymap=disparity/max(disparity(:));
 imshow(disparity);
