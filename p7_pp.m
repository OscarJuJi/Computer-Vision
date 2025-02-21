close all;
clc;

img = imread("test.jpg");

img = rgb2gray(img);

[m, n] = size(img);

P = NaN(size(img));
P(1,:) = img(1,:);
P(:,1) = img(:,1);

for i = 2 :(m-1)
    for j = 2:(n-1)
    
        values = P(i-1:i+1, j-1:j+1);
        
        P(i,j) = nanmean(values(:));
        
    end
    values = P(i-1:i+1, j-1:j);
    
    P(i,j+1) = nanmean(values(:));
end

for j = 2:(n-1)
    
        values = P(i-1:i+1, j-1:j+1);
        
        P(i+1,j) = nanmean(values(:));
        
end
values = P(i-1:i+1, j-1:j+1);

P(i+1,j+1) = nanmean(values(:));

P = uint8(P);

disp(P);
figure (1);
imshow(img);
figure (2);
imshow(P);
