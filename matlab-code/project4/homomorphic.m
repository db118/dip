function [output]=homomorphic(input,radius)
gammal = 0.20;
gammah = 0.80;
image=im2double(input);
[height, width]=size(image);
picture2 = zeros(height,width);
for x=1:height
   for y=1:width
      picture2(x,y)=image(x,y)*((-1)^(x+y));
   end
end
spectrum = fft2(picture2);
center_height=fix(height/2+.5);
center_width=fix(width/2+.5);
gaussian=ones(height,width);
for x=1:height
   for y=1:width
      D= sqrt((x-center_height).^2+(y-center_width).^2) ;
      gaussian(x,y)=1-exp(-1*(D.^2)/(2*(radius.^2)));
   end
end
filter=((gammah-gammal)*gaussian)+gammal;
spectrum2= filter.*spectrum;
image2=abs(real(ifft2(spectrum2)));
if max(max(image2))>1.0
    image2=image2/max(max(image2));
end
output=uint8(image2);
