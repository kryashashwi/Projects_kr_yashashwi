function [img,w3,w4,w1,w2]=whitespaceremove(Inp)
%u_out = RemoveWhiteSpace(Inp);
u_out=Inp;
I=im2double(u_out);
win=I(1:size(I,1),1);
th=10;
w1=1;
while(size(I,1)-length(win(win==1.0000))<th)
    w1=w1+1;
    win=I(1:size(I,1),w1);
end
w2=size(I,2);
winb=I(1:size(I,1),size(I,2));
while(size(I,1)-length(winb(winb==1.0000))<th)
    w2=w2-1;
    winb=I(1:size(I,1),w2);
end

w3=1;
winu=I(1,1:size(I,2));
while(size(I,2)-length(winu(winu==1.0000))<th)
    w3=w3+1;
    winu=I(w3,1:size(I,2));
end

w4=size(I,1);
winub=I(w4,1:size(I,2));
while(size(I,2)-length(winub(winub==1.0000))<th)
    w4=w4-1;
    winub=I(w4,1:size(I,2));
end

img=I(w3:w4,w1:w2);
end