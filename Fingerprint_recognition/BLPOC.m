function [a,rfgabs, AbsOfRFG,I1D,I2D]=BLPOC(I1,im2)
I1D=fftshift(fft2(I1));
I2D=fftshift(fft2(im2));
T1=I1D.*conj(I2D);
Rfg=T1./abs(T1); %Cross Spectrum
AbsOfRFG = abs(Rfg);
%rfg=(ifft2(Rfg));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DFT plot
%   imagesc(log(abs(I1D))+1,[-1 18]);
%   colormap (jet); colorbar;
%  figure();
%  imagesc(log(abs(I2D))+1,[-1 18]);
%  colormap (jet); colorbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y1= round(size(I1D,1)/5);
y2=round(4/5*size(I1D,1));
x1 =round(size(I1D,2)/5);
x2=round(4/5*(size(I1D,2)));
Rfgfiltered=Rfg(y1:y2,x1:x2);
rfgfiltered=ifft2(ifftshift((Rfgfiltered)));


sortrfgfiltered=sort(abs(rfgfiltered(:)));
a1=sortrfgfiltered(length(sortrfgfiltered));
a2=sortrfgfiltered(length(sortrfgfiltered)-1);
a=a1+a2; %Matching score
%disp(a);
rfgabs=abs(rfgfiltered);
% surf(abs(rfgabs),'FaceColor','black','EdgeColor','none','FaceAlpha',0.4);
% camlight left; lighting phong;
end