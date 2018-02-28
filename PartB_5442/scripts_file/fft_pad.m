%% function fft_pad
% kanei pad thn eikona me mhdenika gia na efarmostei fourier
% metasxhmatismos kai syneli3h sth syxnothta me vash oti to filtro 8a einai
% to idio mege8os me thn eikona opote 8a kanoume pad thn eikona se mege8os
% (2*x - 1) kai (2*y - 1)
% gia eikones me diastaseis-dimensions  m x n x 1 (grayscale)

function [padded] = fft_pad(img)

[x,y,d] = size(img);
if d>1
    fprintf('warning : you chose a non grayscale image. we will convert it\n');
    img = rgb2gray(img);
end
padded = zeros((2*x)-1,(2*y)-1);
padded(1:x,1:y) = img(1:x,1:y);
end