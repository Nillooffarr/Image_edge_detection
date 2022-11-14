clc; clear; 
I = imresize((imread('lenna.png')),0.5);
Inew = padarray(I,[0 0]);
[Row,Col] = size(Inew);
figure
Filter = imgaussfilt(double(I),5);
subplot(2,2,1)
imshow(Filter,[])
title('Smoothed Image');
Input = double(I);
[Gmag ,Gdir] = imgradient(Input);
subplot(2,2,2)
imshow(Gmag,[]);
title('Gradient Magnitude');
mask=[0,1,0;1,-4,1;0,1,0];
Lap = conv2(Gmag,mask);
subplot(2,2,3)
imshow(Lap,[])
title('Laplacian of Image')
Lham = zeros(Row,Col);
Ut = zeros(Row,Col,1);
Ut(:,:,1) = Input;
t=1;
Time =30;
Th = 0.1*max(abs(Lap(:)));
for i=2:Row-1
    for j=2:Col-1
        if Lap(i,j-1)*Lap(i,j+1)<0 && abs(abs(Lap(i,j-1))-abs(Lap(i,j+1)))>=Th
            Lham(i,j) = exp(-1/Gmag(i,j));
        elseif Lap(i-1,j-1)*Lap(i+1,j+1)<0 && abs(abs(Lap(i-1,j-1))-abs(Lap(i+1,j+1)))>=Th
            Lham(i,j) = exp(-1/Gmag(i,j));
        elseif Lap(i-1,j)*Lap(i+1,j)<0 &&  abs(abs(Lap(i-1,j))-abs(Lap(i+1,j)))>=Th
            Lham(i,j) = exp(-1/Gmag(i,j));
        elseif Lap(i-1,j+1)*Lap(i+1,j-1)<0 && abs(abs(Lap(i-1,j+1))-abs(Lap(i+1,j-1)))>=Th
            Lham(i,j) = exp(-1/Gmag(i,j));
        else
            Lham(i,j) = 1- exp(-1/Gmag(i,j));
        end
        for t=1:Time
            [Div,Divg] = myDiv(Ut(:,:,t),i,j,4,150);
            Ut(i,j,t+1) = ((Lham(i,j)*Div + (1-Lham(i,j))*Divg))+ Ut(i,j,t);
        end
    end
end
subplot(2,2,4)
imshow(Lham,[])
title('\lambda');
Out=uint8(Ut(2:Row-1,2:Col-1,end));
figure
imshow(Out);
