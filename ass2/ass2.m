p = imread('pollen.tif')
b = imread('bone-scan-GE.tif')
imshow(p)
imshow(b)
% when imshow displays an double image, it displays an intensity
of 0 as black and 1 as white
pd = double(p)
whos pd
bd = double(b)
whos bd

p([23:25], [1:3]) = double(p([23:25], [1:3])) % Nothing changes. The double method cannot covert pixel values in some area of a matrix.
b(1, 1) = double(b(1, 1))

img = imread('nuclei.tif')
% scaled double image to the range [0,1]
img = mat2gray(img)

% calculates the threshold value by maximizing the weighted distances between the global mean of the image histogram and the means of the background and foreground intensity pixels.
T = graythresh(img)

% Thresholding converts grayscale image into an image that contain only two colors. The function im2bw() assigns black color to all the pixels that have luminosity than a threshold level and the others as white. the function graythresh() approximately calculates the threshold of the image.
% create a new binary image using the obtained threshold value
imgb = im2bw(img, T)

% enumerate all the objects in the figure using the bwlabel
% L gives the labeled image, and num gives the number of objects
[L, N] = bwlabel(imgb)

D = regionprops(L, 'area')
w = [D.Area]
mean(w)

function c = count(fname)
  % load image with name fname
  img = imread(fname);
  % scale double image to the range [0,1]
  img = mat2gray(img);
  % calculate the threshold value
  T = graythresh(img);
  % create a new binary image using the obtained threshold value
  imgb = im2bw(img, T);
  % enumerate all the objects in the figure
  % L gives the labeled image, and num gives the number of objects
  [L, N] = bwlabel(imgb);
  c = N
end

function a = area(fname)
  img = imread(fname);
  img = mat2gray(img);
  T = graythresh(img);
  imgb = im2bw(img, T);
  [L, N] = bwlabel(imgb);
  D = regionprops(L, 'area');
  w = [D.Area];
  a = mean(w);
end


img = imread('rice.png');
background = imopen(img, strel('square', 15));
img2 = imsubtract(img, background);
img3 = imadjust(img2);
level = graythresh(img3);
imgb = im2bw(img3, level);
[L, N] = bwlabel(imgb);
props = regionprops(L, 'basic');
cc = bwconncomp(imgb,4);
cc.NumObjects;
hist([props.Area]);
min_area = 150;
area.isLesser = find([props.Area] < min_area);

for i = area.isLesser
  imgb(cat(1,cc.PixelIdxList{i})) = false;
end

areas = [props.Area];
for i = area.isLesser
  areas(i) = []
end


