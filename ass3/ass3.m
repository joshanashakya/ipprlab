% 1
a = fft([2, 3, 4, 5]);
b = fft([2, -3, 4, -5]);
c = fft([-9, -8, -7, -6]);

% 2
inva = ifft([14 +  0i,   -2 +  2i,   -2 +  0i,   -2 -  2i]);
invb = ifft([-2 +  0i,   -2 -  2i,   14 +  0i,   -2 +  2i]);
invc = ifft([-30 +  0i,   -2 +  2i,   -2 +  0i,   -2 -  2i]);

% 3
mat = [4, 5, -9, -5; 3, -7, 1, 2; 6, -1, -6, 1; 3, -1, 7, -5];
dft_mat = fft(mat, [], 2);

test = [2, 3, 4, 5; 2, -3, 4, -5; -9, -8, -7, -6];

% Learn1
a = ones(8);
F = fft2(a);
% shift DC component to the center
SF = fftshift(F);

% Learn2
a = zeros(256, 256);
a(78:178, 78:178) = 1;
figure, imshow(a);
af = fft2(a);
af = fftshift(af);
% Since F(u, v) are complex we can't view them directly. To display magnitude:
af1 = log(1+abs(af));
fn = max(af1(:));
figure, imshow(im2uint8(af1/fn));
figure, imshow(mat2gray(af1));

% Learn3
[x, y] = meshgrid(-128:127, -128:127);
z = sqrt(x.^2+y.^2);
c = (z<15);
figure, imshow(c);

cf = fftshift(fft2(c));
cf1 = log(1+abs(cf));
m = max(cf1(:));
figure, imshow(im2uint8(cf1/m));

b = 1./(1+(z./15).^2);
figure, imshow(b)

cf = fftshift(fft2(b));
cf1 = log(1+abs(cf));
m = max(cf1(:));
figure, imshow(im2uint8(cf1/m));

% Learn4
function [] = fftshow(f)
  f1 = log(1+abs(f));
  fm = max(f1(:));
  figure, imshow(im2uint8(f1/fm));
end

function [] = ifftshow(f)
  f1 = abs(f);
  fm = max(f1(:));
  figure, imshow(f1/fm);
end

a = imread('cameraman.tif');
af = fftshift(fft2(a));
figure, imshow(af);
fftshow(af);

[x, y] = meshgrid(-128:127, -128:127);
z = sqrt(x.^2+y.^2);
c = z<15;

af1 = af.*c;
fftshow(af1);
af1i = ifft2(af1);
ifftshow(af1i);

c=z<5;
af1 = af.*c;
fftshow(af1);
af1i = ifft2(af1);
ifftshow(af1i);

c=z<40;
af1 = af.*c;
fftshow(af1);
af1i = ifft2(af1);
ifftshow(af1i);

% Learn5
[x, y] = meshgrid(-128:127, -128:127);
z = sqrt(x.^2+y.^2);
c = z>15;
a = imread('cameraman.tif');
af = fftshift(fft2(a));
hp = af.*c;
fftshow(hp);
hpi = ifft2(hp);
ifftshow(hpi);

c = z>50;
a = imread('cameraman.tif');
af = fftshift(fft2(a));
hp = af.*c;
fftshow(hp);
hpi = ifft2(hp);
ifftshow(hpi);

% Learn6(Butterworth high pass filter)
% d = cut off frequency
% n = order
function [out] = butterhp(im, d, n)
  h = size(im, 1); % height
  w = size(im, 2); % width
  [x, y] = meshgrid(-floor(w/2):floor((w-1)/2), -floor(h/2):floor((h-1)/2));
  out = 1./(1.+(d./(x.^2+y.^2).^0.5).^(2*n));
end

a = imread('engineer.tiff');
hb = butterhp(a, 15, 1);
af = fftshift(fft2(a));
fftshow(af);
afhb = af.*hb;
fftshow(afhb)
afhbi = ifft2(afhb);
ifftshow(afhbi);

% Learn7(Butterworth low pass filter)
function [out] = butterlp(im, d, n)
  out = 1 - butterhp(im, d, n);
end

a = imread('cameraman.tif');
lp = butterlp(a, 15, 1);
af = fftshift(fft2(a));
fftshow(af);
aflp = af.*lp;
fftshow(aflp)
aflpi = ifft2(aflp);
ifftshow(aflpi);

% Learn8 (Gaussian Filtering - narrow low pass filter)
a = imread('cameraman.tif');
% size of the filter = size of image = 256
% standard deviation = 10
g = fspecial('gaussian', 256, 10);
max(g(:));
% as the value is small we apply this
g1 = mat2gray(g);
max(g1(:));
af = fftshift(fft2(a));
ag1 = af.*g1;
fftshow(ag1);
ag1i = ifft2(ag1);
ifftshow(ag1i);

% 4
en = imread('engineer.tif');
figure, imshow(mat2gray(en));
enf = fft2(en);
% shift DC component to the center
enf = fftshift(enf);
% Since F(u, v) are complex, we can't view them directly. So, we display them using this:
enf1 = log(1 + abs(enf));
fn = max(enf1(:));
figure, imshow(im2uint8(enf1/fn));

% 4a
function ideallp(im, D0)
  % Save the size of image in pixels 
  % h: no of rows (height of the image)
  % w: no of columns (width of the image)
  [h, w] = size(im);
  % Get Fourier Transform of image using fft2 (2D fast fourier transform)
  imf = fft2(im);
  % Assign cut-off frequency
  % D0 = 30;
  % Design a filter
  u = 0:(h-1);
  v = 0:(w-1);
  idx = find(u>h/2);
  idy = find(v>w/2);
  u(idx) = u(idx) - h;
  v(idy) = v(idy) - w;
  % Create 2D grid which contains the coordinates of vectors v and u.
  % Matrix V with each row is a copy of v, and matrix U is a copy of u.
  [x, y] = meshgrid(v, u);
  % Calculate Euclidean distance
  D = sqrt(x.^2 + y.^2);
  % Compare with the cut-off frequency and determine the filtering mask
  c = D <= D0;
  % Convolution between the Fourier Transformed image and the mask
  imf1 = imf.*c;
  imf1i = ifft2(imf1);
  ifftshow(imf1i);
end

function idealhp(im, D0)
  % Save the size of image in pixels 
  % h: no of rows (height of the image)
  % w: no of columns (width of the image)
  [h, w] = size(im);
  % Get Fourier Transform of image using fft2 (2D fast fourier transform)
  imf = fft2(im);
  % Assign cut-off frequency
  % D0 = 30;
  % Design a filter
  u = 0:(h-1);
  v = 0:(w-1);
  idx = find(u>h/2);
  idy = find(v>w/2);
  u(idx) = u(idx) - h;
  v(idy) = v(idy) - w;
  % Create 2D grid which contains the coordinates of vectors v and u.
  % Matrix V with each row is a copy of v, and matrix U is a copy of u.
  [x, y] = meshgrid(v, u);
  % Calculate Euclidean distance
  D = sqrt(x.^2 + y.^2);
  % Compare with the cut-off frequency and determine the filtering mask
  c = D >= D0;
  % Convolution between the Fourier Transformed image and the mask
  imf1 = imf.*c;
  imf1i = ifft2(imf1);
  ifftshow(imf1i);
end

im = imread('engineer.tif');
ideallp(im, 20);
idealhp(im, 20);

% 4b
% D0: cut-off frequency
% n: order
function butterhp(im, D0, n)
  [h, w] = size(im);
  [x, y] = meshgrid(-floor(w/2):floor((w-1)/2), -floor(h/2):floor((h-1)/2));
  bw = 1./(1.+(D0./(x.^2+y.^2).^0.5).^(2*n));
  imf = fftshift(fft2(im));
  imf1 = imf.*bw;
  imf1i = ifft2(imf1);
  ifftshow(imf1i);
end

im = imread('engineer.tif');
butterhp(im, 30, 1);

% 4c
function gaussianlp(im, D0)
  [h, w] = size(im);
  g = fspecial('gaussian', [h, w], D0);
  g1 = mat2gray(g);
  imf = fftshift(fft2(im));
  imf1 = imf.*g1;
  imf1i = ifft2(imf1);
  ifftshow(imf1i);
end

im = imread('engineer.tif');
gaussianlp(im, 10);