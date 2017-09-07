
%    Inpo=imread('F:\moodle\sem5\CS663 Digital Image Processing\project\database\FINGERPRINT.jpg');
%    Inpp=im2double(Inpo);
%    img=imresize(Inpp,0.5);
function [row ,col,absimg]=complexNew(Inpp,m,sig)
%img=imresize(Inpp,0.5);
img=Inpp;
%%%%%%%%%%%%%%%%%%%%%%%%

[Ix Iy] = gradient(img);
%m = 2; sig =8;

Z = (Ix + 1i*Iy).^2 ;
temp_mat_x = -15:15;
temp_mat_y = 15:-1:-15;
x_coord = repmat(temp_mat_x , [31 1]);
y_coord = repmat(temp_mat_y' , [1 31]);
%disp(size(y_coord));
filter =  (x_coord+ 1i*y_coord).^m;
g = exp(-(x_coord.^2 + y_coord.^2)/(2*sig^2));
Fc = filter.*g;

filteredImg = conv2(Z,Fc,'same');
absimg = abs(filteredImg);

%figure; imshow(absimg, [min(absimg(:)), max(absimg(:))]);
%hold on;
max_val = max(absimg(:));
[row col] = find( absimg == max_val);
%length = size(row,1);
%for idx = length:-1:length-5
%    scatter(row(idx, col(idx),90,[1 0 0],'filled','^');
%end
%scatter(col, row,90,[1 0 0],'filled','^');
% scatter(col, row);
% figure();
% imshow(img)
% hold on;
% scatter(col, row);
end
%%%%%%%%%%%%%%%%%%%%%%%%%