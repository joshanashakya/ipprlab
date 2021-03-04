% 1.

% the first 15 cubes
(1:15) .^ 3 

% the values sin(nπ/16) for n from 1 to 16
sin(((1:16) .* pi)./16) 


% 2.
A = [1 2 3; 2 3 4; 3 4 5]
B = [-1 2 -1; -3 -4 5; 2 3 -4]
C = [0 -2 1; -3 5 2; 1 1 -7]

% 2A - 3B
2 * A - 3 * B

% A transpose
A'

% AB - BA
A * B - B * A 

% BC^-1
B * inv(C) 

% (AB) transpose
(A * B)' 

% B transpose * A transpose
B' * A' 

% A^2 + B^3
(A .^ 2) + (B .^ 3) 

w = imread('cameraman.tif')
figure, imshow(w)

a = imread('autumn.tif')
figure, imshow(a)
size(a)
imfinfo(a)

