%PART C (ADDITIONAL)
%-------------------------------------------------------------------------%
clc;
%Load file source here
load('C:\Users\Jazz Hong\Desktop\Digital Comm\Lena.mat');
load('C:\Users\Jazz Hong\Desktop\Digital Comm\M.mat');

%Double the image as load function has load the image matrix
img=double(Lena);

mse = []; 
psnr = []; 

%Getting 8x8 matrix, breaking down the big image into 8x8 matrix blocks, 
%Thus need blockproc function for combination 
%Note tht blockproc function is repeating the same process on each of every
%block as fully combine to form full image
T=dctmtx(8);

%Quantise interval
Q_interval=M;

%Perform DCT formula DCT=f(x,y)=T*F(u,v)*T' for each block
DCT=@(block_struct)T*(block_struct.data)*T';

%Getting full DCT using block process 
Combined_DCT=blockproc(img,[8 8], DCT);
Matrix_coefficient=Combined_DCT

Quantized_values=@(block_struct)(block_struct.data)./Q_interval;
Combine_Quantized_values = blockproc(Matrix_coefficient, [8 8], Quantized_values);
quantized_DCT_coefficients=round(Combine_Quantized_values)

Restore_values=@(block_struct)(block_struct.data).*Q_interval;
Combine_Restore_values = blockproc(Matrix_coefficient, [8 8], Quantized_values);

%Defining Inverse DCT 
%Inverse_DCT=idct2(Combine_Restore_values) 
In_DCT=@(block_struct)T'*(block_struct.data)*T ;
Combined_In_DCT=blockproc(Combine_Restore_values ,[8 8],In_DCT);   

%See the comparison between images
%-------------------------------------------------------------------------%
%Here is the original img
imwrite(img,'Original Image.jpg','quality',100); 

%Here is the re-constructed (Compressed)image
%with same index image quality of 100
%uint=unsign integer help change to positive integer from 0-255
%Because picture only contains integer value like pixels in the image
imwrite(uint8(Combined_In_DCT),'De-quantized-Restore Image.jpg','quality',100);  

%Access the quality of image 
%-------------------------------------------------------------------------%
X = Combined_In_DCT;
Xapp = X;
Xapp(X<=100) = 1;
[psnr,mse,maxerr,L2rat] = measerr (X,Xapp)

%-------------------------------------------------------------------------%   
%Dislay the graph between image quality vs compression
for Q_interval=Q_interval:Q_interval:10*Q_interval
    %Here are just repeating the process in a loop
    Quantized_values=@(block_struct)(block_struct.data)./Q_interval;
    Combine_Quantized_values = blockproc(Matrix_coefficient, [8 8], Quantized_values);
    quantized_DCT_coefficients=round(Combine_Quantized_values)

    Restore_values=@(block_struct)(block_struct.data).*Q_interval;
    Combine_Restore_values = blockproc(Matrix_coefficient, [8 8], Quantized_values);

    In_DCT=@(block_struct)T'*(block_struct.data)*T ;
    Combined_In_DCT=blockproc(Combine_Restore_values ,[8 8],In_DCT);   
    
    X = Combined_In_DCT;
    Xapp = X;
    Xapp(X<=100) = 1;
    [psnr,mse,maxerr,L2rat] = measerr (X,Xapp)
    
    mse = [mse; maxerr];
    psnr = [psnr; L2rat];
end

figure; 
title('Image Quality VS Compression');
%Plot(X,Y) 
plot(psnr, mse);
grid on
xlabel('Compression');
ylabel('Image Quality');
