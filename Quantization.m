%QUANTIZATION 

close all,clear all,clc

img=imread('apple.jpeg');
A=rgb2gray(img);
imshow(A)
title('Original image')

[ROW,COLUMN]=size(A)

%At here, we can get the full image size (ixj) 
for i=1:ROW
    for j=1:COLUMN
        M=A(i,j);
        if M<=50                %Condition 1, M is meaning = Level,2^8=256
            A(i,j)=10;          %2^M=2^8=256 levels    
        
        elseif M>50 && M<=100   %Condition 2, greater than 50 and less than 100
            A(i,j)=70;
        
        elseif M>100 && M<=180  %Condition 3
            A(i,j)=150;
        
        elseif M>180 && M<=255  %Condition 4
            A(i,j)=210;
        end
    end
end

figure
imshow(A);
title('Quantised Image');
    
