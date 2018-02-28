%% 1o_erotima (grammes - sthles)

close all; clear all; clc

clock = rgb2gray(im2double(imread('clock.jpg')));

[x,y] = size(clock);

% fft kata grammes(arxika) kai fft kata sthles se auto to apotelesma me 
% me xrhsh for
for i = 1:x
    fft_grammes(i,:) = fft(clock(i,:));
end
for j = 1:y
    fft_sthles(:,j) = fft(fft_grammes(:,j));
end

clock_new = fft_sthles ;

% shift sta epimerous kommatia ths eikonas opws ypodeiknyetai (ta floor kai
% ceil xrhsimopoih8hkan giati den eixame tetragwnisei thn eikona
fst_q = clock_new(1:floor(x/2),1:floor(y/2));
scd_q = clock_new(1:floor(x/2),ceil(y/2):y);
thd_q = clock_new(ceil(x/2):x,1:floor(y/2));
fth_q = clock_new(ceil(x/2):x,ceil(y/2):y);

% synenwsh twn epimerous kommatiwn
clock_new = [fth_q thd_q; scd_q fst_q];
% parousiash (edw xrhsimopoih8hkan kapoies metablhtes gia na emfanistei to
% apotelesma, p.x sth grammikh apeikonish /100, sth logari8mikh log2 kai
% log10 plhn mia mikrh sta8era)
figure,subplot(1,3,1),imshow(clock),title('clock')
subplot(1,3,2),imshow(abs(clock_new)/100),title('FFT - linear')
subplot(1,3,3),imshow(log2(log10(abs(clock_new))-0.1)),title('FFT - logarithmic')