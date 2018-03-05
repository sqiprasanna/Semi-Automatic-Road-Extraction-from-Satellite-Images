clc;
clear all();
close all();

fid=fopen('ds9.jpg','r');
image=fread(fid, [427 427],'uint8');  
figure(1);

M=max(max(image));
C=image'/M;
n=size(C,2)-2;
matlabpool open ;   
parfor i=1:size(C,1)-2    
    for j=1:n
        %Sobel mask for x-direction:
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        %Sobel mask for y-direction:
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
      
        %The gradient of the image
        %B(i,j)=abs(Gx)+abs(Gy);
        B(i,j)=sqrt(Gx.^2+Gy.^2);
      
    end
end
matlabpool close ; 
figure
imshow(B); title('Sobel gradient');