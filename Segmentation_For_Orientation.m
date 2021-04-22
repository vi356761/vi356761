[file, pathname] = uigetfile({'*.jpg';'*.tif'});
I = imread([pathname,file]);
%J = histeq(I); figure; imshow (J);
%I = rgb2gray(I);
%J = rgb2gray(J);
%BW = imbinarize(J, 'adaptive', 'Sensitivity', 1.00, 'ForegroundPolarity', 'bright');
BW = imbinarize(I, 'adaptive', 'Sensitivity', 0.8500000, 'ForegroundPolarity', 'bright');
imshow(BW)
filepath = ('E:\New Analysis\Raw Images\1.2K\1.2K_2\');
fullfile = ([filepath,'1.2kthreshMat.tif']);
%imwrite(J,fullfile);
X2 = imcomplement(BW);
figure;imshow(X2)
X3 = bwareaopen(X2,100);imshow(X3)
%X3 = bwareaopen(X2,30);imshow(X3)
se = strel('disk',1);
X1 = imdilate(X3,se); imshow(X1)
X4 = imfill(X1,'holes');imshow(X4)
D = -bwdist(~X4);
imshow(D,[])
Ld = watershed(D);
figure;imshow(label2rgb(Ld))
mask = imextendedmin(D,2);
imshowpair(X4,mask,'blend')
D2 = imimposemin(D,mask);
Ld2 = watershed(D2);
bw3 = X4;
bw3(Ld2 == 0) = 0;
imshow(bw3)
I=bw3;
imshow(I);
%%
% FOR CREATING DOMAIN & CROPPED IMAGE 
% hFH = roipoly();
% % Create a binary image ("mask") from the ROI object.
% %binaryImage = hFH.createMask();
% binaryImage = hFH;
% figure;imshow(binaryImage);
% fullfile = ([filepath,'domain1.tif']);
% imwrite(binaryImage,fullfile);
% %xy = hFH.getPosition;
% blackMaskedImage = I;
% blackMaskedImage(~binaryImage) = 0;
% figure;imshow(blackMaskedImage);
% fullfile = ([filepath,'thresh1.tif']);
%%
imwrite(I,fullfile)
close all;