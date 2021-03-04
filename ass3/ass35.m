% Read an input image
im = imread('myphoto.jpeg');
% Convert rgb2 gray
im = rgb2gray(im);
ideallp(im, 20);
idealhp(im, 20);

im = imread('myphoto.jpeg');
% Convert rgb2 gray
im = rgb2gray(im);
butterhp(im, 30, 1);

im = imread('myphoto.jpeg');
% Convert rgb2 gray
im = rgb2gray(im);
gaussianlp(im, 10);