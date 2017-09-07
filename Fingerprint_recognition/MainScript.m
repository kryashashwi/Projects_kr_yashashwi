Inp1=imread('./database/104_5.tif');
Inp2=imread('./database/104_2.tif');
[matchingscore,rfgabs]=fingerprintmatching(im2double(Inp1),im2double(Inp2));
figure();
surf(abs(rfgabs),'FaceColor','black','EdgeColor','none','FaceAlpha',0.4);
camlight left; lighting phong;
coredetection(Inp1,Inp2);


