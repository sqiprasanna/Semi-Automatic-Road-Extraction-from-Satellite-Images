clc
clear all;
close all;
I=imread('du11.jpg');
figure;
imshow(I);
title('Original image');
 
J=rgb2gray(I); 
figure;
imhist(J);   
title('Histogram');                    % Observe the histogram of grayscale
 
 
%Linear transformation makes the dynamic range and variance of image data larger, increasing the interpretability of the image, the brightness range can be extended to any range (remote sensing image processing can not exceed0?255)?
K=imadjust(J,[0.5 0.9],[]); %Local stretch?Put[0.6 0.95]Gray scale within the stretch[0 1]
figure;
imshow(K);
figure;
imhist(K);
title('Linear transform image[0.5 0.9]');
level = graythresh(K);  %Find the appropriate threshold for the image using the Max-Variance method?threshold??Adaptive threshold determinationOTSU
I=im2bw(K,level);     %Binary image
figure;
imshow(I);
title('Linear transformation threshold segmentation binary image');
 
figure;
kk1=medfilt2(I);            %3 * 3 template median filter (linear smoothing)
subplot(221),
imshow(kk1);title('3 * 3 template median filter');  
 
kk2=medfilt2(I,[5,5]);      %5 * 5 template median filter
subplot(222),
imshow(kk2);title('5 * 5 template median filter');
 
kk3=medfilt2(I,[7,7]);      %7 * 7 template median filter
subplot(223),
imshow(kk3);title('7 * 7 template median filter');
 
kk4=medfilt2(I,[9,9]);      %9 * 9 template median filter
figure;
imshow(kk4);title('9 * 9 template median filter'); 
%%imwrite(kk2,'5 × 5 median filter binary map.bmp');
figure;
imshow(kk2);
title('5 * 5 template median filter');
 
%Opens a graph of processing elements using the form of a structural element  
se=strel('square',3);%Constructs a square structure element
H=imopen(kk2,se);%Open the first corrosion after the expansion, you can make the border smooth, eliminate small spikes, disconnect the narrow connection, keep the size of the same?
figure;
imshow(H);
title('3 × 3 structure elements of the form of open computing process diagram');  
%%imwrite(H,'3×3openoperation.bmp');         
se=strel('square',5);
H1=imopen(kk2,se);
figure;
imshow(H1);
title('5×5The structural elements of the form of open operation processing diagram');  
%%imwrite(H1,'5×5Operate.bmp');  
 
%lineThe structural elements of the morphological corrosion treatment diagram
se=strel('line',100,90);               %Create a straight line length100?angle90
A2=imerode(H,se);                      %Morphological erosion treatment, as a morphological reconstruction of the marker image
figure;
imshow(A2);
title('lineThe structural elements of the morphological corrosion treatment diagram');  
 
%Marked images and mask images for morphological reconstruction
fobr=imreconstruct(A2,H1);
figure;
imshow(fobr);
title('Morphological reconstruction operation processing diagram');  
 
 
%Form closure operations fill gaps in the network?At the same time connect the breakpoint?Got a patched road network
se=strel('square',5);
fc=imclose(fobr,se);
figure;
imshow(fc);
title('Form closure operation processing diagram');  
 
%After the reconstruction of the shape of the road network information shape refinement
ginf=bwmorph(fc,'thin',4);  %infSaid the call bwmorphThe command will repeat this operation?Until the image stops changing
figure;
imshow(ginf);
title('Shape refinement processing diagram');  
%%imwrite(ginf,'FinalResult.tif');
