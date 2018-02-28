%% function inverse_pad
% epanaferei th padded eikona sto arxiko ths mege8os afou exei
% xrhsimopoih8ei sthn eikona h synarthsh fft_pad

function [original] = inverse_pad(padded)

[x,y,d] = size(padded);
x = x + 1;
y = y + 1;
original = padded(1:(x/2),1:(y/2));
end