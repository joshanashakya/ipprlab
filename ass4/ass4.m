3 148 117 148 145 178 132 174
2 176 174 110 185 155 118 165
0 100 124 113 193 136 146 108
0 155 170 106 158 130 178 170
9 196 138 113 108 127 144 139
6 188 143 183 137 162 105 169
9 122 156 119 188 179 100 151
8 176 137 114 135 123 134 183

% 1
function [] = display_image(b, threshold_level)
  imgb = im2bw(b, threshold_level/255);
  figure, imshow(imgb);
end

mat = [3 148 117 148 145 178 132 174; 2 176 174 110 185 155 118 165; 0 100 124 113 193 136 146 108; 0 155 170 106 158 130 178 170; 9 196 138 113 108 127 144 139; 6 188 143 183 137 162 105 169; 9 122 156 119 188 179 100 151; 8 176 137 114 135 123 134 183];
b = uint8(mat);
display_image(b, 100);
display_image(b, 150);

% 2
t = imread('text.tiff');
c = imread('cameraman.tif');
m = uint8(double(c) + 255 * double(t));

threshold_level = 253;
timg = im2bw(m, threshold_level/255);
figure, imshow(timg);

% 3
function [g] = contrast_stretching(f, m, E)
  g = 1 ./ (1 + (m ./ (double(f) + eps)) .^ E);
end
f = imread('spectrum.tif');
g = contrast_stretching(f, 5, 1.5);
figure, imshow(f);
figure, imshow(g);

c = 5;
g = c * log(1 + double(f));
img = im2uint8(mat2gray(g));
figure, imshow(img);

% 4
f = imread('chest-xray.tif');
imshow(f);
g1 = imadjust(f);
imshow(g1);
g2 = imadjust(f, [0 1], [1 0]);
figure, imshow(g2);

% 5
f = imread('ckt-board-orig.tif');
imshow(f);
% add noise
fn = imnoise(f, 'salt & pepper', 0.2);
figure, imshow(fn);
img_noisy = fn;
img_filtered = img_noisy;
% use median filter
for c = 1 : 3
    img_filtered(:, :, c) = medfilt2(img_noisy(:, :, c), [3, 3]);
end
figure; imshow(img_filtered);

f = imread('pollen.tif');
imshow(f);
% add noise
fn = imnoise(f, 'salt & pepper', 0.2);
figure, imshow(fn);
gm = medfilt2(fn);
figure; imshow(gm); 

f = imread('myphoto.tif');
% add noise
fn = imnoise(f, 'salt & pepper', 0.2);
figure, imshow(fn);
img_noisy = fn;
img_filtered = img_noisy;
% use median filter
for c = 1 : 3
    img_filtered(:, :, c) = medfilt2(img_noisy(:, :, c), [3, 3]);
end
figure; imshow(img_filtered);