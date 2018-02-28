%% 1o_erotima (pinakas DFT)

close all; clear all; clc

clock = rgb2gray(im2double(imread('clock.jpg')));

[x,y] = size(clock);

% checking dimensions
if x == y
    W = zeros(x);
    glo_var = x;
elseif x > y
    clock = imresize(clock,[x,x]);
    W = zeros(x);
    glo_var = x;
elseif y > x
    clock = imresize(clock,[y,y]);
    W = zeros(y);
    glo_var = y;
end

% ypologismos ths arxikhs grammhs omega
for i = 1:glo_var
    omega(1,i) = exp((-2*pi*1i/glo_var)*(i-1));
end

% ypswnontas to omega sthn i-1 epitygxanetai h morfh toy mhtrwou pou
% zhteitai
for i = 1:glo_var
    W(i,:) = omega.^(i-1);
end

% kanonikopoihsh tou W diairontas me to sqrt(N)
W = (1/sqrt(glo_var))*W;

clock_new = W*clock*W';

% shift sta epimerous kommatia ths eikonas opws ypodeiknyetai
fst_q = clock_new(1:floor(glo_var/2),1:floor(glo_var/2));
scd_q = clock_new(1:floor(glo_var/2),ceil(glo_var/2):glo_var);
thd_q = clock_new(ceil(glo_var/2):glo_var,1:floor(glo_var/2));
fth_q = clock_new(ceil(glo_var/2):glo_var,ceil(glo_var/2):glo_var);

% synenwsh twn kommatiwn
clock_new = [fth_q thd_q; scd_q fst_q];

% emfanish apotelesmatwn
figure,subplot(1,3,1),subimage(abs(clock)),title('clock')
subplot(1,3,2),subimage(abs(clock_new)),title('DFT - linear')
subplot(1,3,3),subimage(log10(10*abs(clock_new))),title('DFT - logarithmic')