clear variables
close all
clc

%read image
img = imread('pic/airport.jpg');
original = img;
figure, imshow(img);
img = rgb2gray(img);
[height, width, color] = size(img);
BW = edge(img, 'canny');
figure, imshow(BW);

rhoMax = sqrt(height .* height + width .* width);
rhoMax = floor(rhoMax);

rhoThreshold = 1;

statistics = zeros(rhoMax, 181, 'uint16');

for thida = -90 : 90
    for y = 0 : (height - 1)
        for x = 0 : (width - 1)
            matlabX = x + 1;
            matlabY = y + 1;
            if(BW(matlabY, matlabX) == 1)
                rhoTarget = floor(x * cosd(thida) + y * sind(thida));
                if(rhoTarget > 0)
                    statistics(rhoTarget + 1, thida + 91) = statistics(rhoTarget + 1, thida + 91) + 1;
                end
            end
        end
    end
end

maxLine = max(statistics(:));
[rhoMaxLine, thidaMaxLine] = find(statistics == maxLine)
rhoMaxLine = rhoMaxLine - 1;
thidaMaxLine = thidaMaxLine - 91;
for y = 1 : height
    for x = 1 : width
        
        yindex = y - 1;
        xindex = x - 1;
        rho = floor(xindex * cosd(thidaMaxLine) + yindex * sind(thidaMaxLine));
        if rhoMaxLine == rho
            original(y, x, 1) = 255;
            original(y, x, 2) = 0;
            original(y, x, 3) = 0;
        end
    end
end

figure, imshow(original);