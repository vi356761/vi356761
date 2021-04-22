[file, pathname] = uigetfile('*.tif','Open first phase image');
I = imread([pathname,file]);
BW = imbinarize(I, 'adaptive', 'Sensitivity', 0.700, 'ForegroundPolarity', 'bright');
figure;imshow(BW)
X2 = imcomplement(BW); imshow(X2)
X3 = bwareaopen(X2,75);imshow(X3)
se = strel('line',30,90);se2 = strel('line',30,0);
BW2 = imdilate(X3,[se,se2]);%figure;%imshow(BW2);
BW3 = imfill(BW2,'holes');
BW4 = bwareaopen(BW3, 80000);figure;imshow(BW4)
boundaries = bwboundaries(BW4);
thisBoundary = boundaries{1};
x = thisBoundary(:, 2); % Columns.
y = thisBoundary(:, 1); % Rows.
%[file2, pathname2] = uigetfile('*.tif');
figure;imshow(I);hold on;plot(x,y,'r')
