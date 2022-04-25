%BME 3053C Homework 2 MATLAB Header and Live Script

%Author: Katelyn Wahl
%Group Members: Isabel Rivera Santiago, Leah Weintraub, Nicole Buenavida
%Course: BME 3053C Computer Applications for BME
%Term: Spring 2022
%J. Crayton Pruitt Family Department of Biomedical Engineering
%University of Florida
%Email: kwahl@ufl.edu
%January 23, 2022

clc; clear; 

% utilize original_glioma or original_meningioma zip files to access and upload original images
% I = input('Filename: ');
I = imread('menin15.jpg'); 

I=imresize(I,[300 300]);  %resize image so that data set is the same size

I = rgb2gray(I); %convert to grayscale
%imshow(I);
%title('Original Image')


[height, width] = size(I); %get height and width of image (kinda redundant...can delete) 
n = floor((height-50)/30)*floor(((width-50)/30)); %getting the number of boxes that we want to examine. 
%A box is a 50x50 area of the image that will be examined. Boxes are allowed to overlap
numPixels = zeros(1,n); %creates an empty vector whose length is the number of boxes. 
%Each index represents an indidual box. The values within this vecotr represent the number of identified "white" pixels within that particular box.
%For example, if numPixels(1) = 45, that means there are 45 identified "white" pixels within box 1. 
%Box 1 corresponds to a certain 50x50 pixel  area on the image.
c = 1;


for i=1:30:width-50 %nested for loop iterates through the image at 30pixel intervals
    for j=1:30:height-50
        for x = i:i+50 %this nested for loop iterates through the 50x50 box that we are examining
            for y = j:j+50
                if I(y,x) > 130 && c < n %if a pizel within this box is "white" 
                    numPixels(c) = numPixels(c)+1; %then count the pixel
                end
            end
        end
        c = c+1; %this counter makes sure we stay within the bounds of numPixel
    end
end

tumor = zeros(1,n); %creating a new vector that identifies boxes with the most "white" pixels
for i=1:n
    if numPixels(i) > 600
        tumor(i) = numPixels(i);
    end
end


rgbImage = cat(3, I, I, I);

cnt=0;

for i=1:30:width-50 %nested for loop iterates through the image at 30 pixel intervals
    for j=1:30:height-50
        cnt = cnt+1; %this counter counts through the numPixel vector of boxes
        if cnt < n && tumor(cnt) > 0
            for x = i:i+50 %iterates through the box that corresponds to cnt
                 for y = j:j+50 
                    if I(y,x) > 130 
                        rgbImage(y,x,:) = [250,0,0]; %makes white pixels red
                    end
                 end
            end
        end
    end
end

imshow(rgbImage)






