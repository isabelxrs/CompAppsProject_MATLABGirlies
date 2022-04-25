clc; clear; 

% I = input('Filename: ');
I = imread('glioma27.jpeg');

I=imresize(I,[300 300]);

I = rgb2gray(I);
%imshow(I);
%title('Original Image')


[height, width] = size(I);
%disp(height)
%disp(width)
n = floor((height-50)/30)*floor(((width-50)/30));
%disp(n);
numPixels = zeros(1,n);
c = 1;


for i=1:30:width-50
    for j=1:30:height-50
        for x = i:i+50
            for y = j:j+50
                if I(y,x) > 130 && c < n
                    %disp(c)
                    %disp(numPixels(c))
                    numPixels(c) = numPixels(c)+1;
                end
            end
        end
        c = c+1;
    end
end

tumor = zeros(1,n);
for i=1:n
    if numPixels(i) > 600
        tumor(i) = numPixels(i);
    end
end

%disp(tumor)

rgbImage = cat(3, I, I, I);

cnt=0;

for i=1:30:width-50
    for j=1:30:height-50
        cnt = cnt+1;
        if cnt < n && tumor(cnt) > 0
            for x = i:i+50
                 for y = j:j+50
                    if I(y,x) > 130
                        rgbImage(y,x,:) = [250,0,0];
                    end
                 end
            end
        end
    end
end

imshow(rgbImage);
title('segmented tumor');
