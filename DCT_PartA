%PART A
%-------------------------------------------------------------------------%
clc;
%Load file source here
load('C:\Users\Jazz Hong\Desktop\Digital Comm\Lena.mat');

%Taking a segment of interested part from the Lena image with 8x8 matrix
ROW=[1:1:8];  
COLUMN=[200:1:207];     
img=Lena(ROW,COLUMN); 
selected_matrix=img

%Perform DCT function on the particular segment in the Lena image
DCT=dct2(double(img)); 

%Here we are displaying the original DCT coefficients
Matrix_coefficient=DCT

%Perform inverse DCT function
In_DCT=idct2(DCT) 

%See the comparison between images
%-------------------------------------------------------------------------%
%Here is the original img
imwrite(img,'Original_Image.jpg','quality',100); 

%Here is the re-constructed (Compressed)image
%with same index image quality of 100
%uint=unsign integer help change to positive integer from 0-255
%Because picture only contains integer value like pixels in the image
imwrite(uint8(In_DCT),'DCT_Compressed_Image.jpg','quality',100);  
                                                            
figure
imshowpair(img,In_DCT,'montage') %Montage=place two imgs nxt to each other
title('Original Grayscale Image (Left) and DCT Compressed Image (Right)');
