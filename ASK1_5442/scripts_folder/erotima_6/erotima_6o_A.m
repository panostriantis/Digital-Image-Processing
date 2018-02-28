%% 6o_erotima A meros
% adding noise

close all; clear all; clc

clock = im2double(rgb2gray(imread('clock.jpg')));
clock = imresize(clock,[301 301]);
[x,y] = size(clock);

% mesh timh = 0
mean = 0;

% diaspora
sigma = 1;

% epi8ymhto snr
SNR = 10;

% dhmiourgia 8orybou
noise = sqrt(sigma)*randn(x,y) + mean;

% euresh meshs isxyos shmatos kai 8oryvou
Power_s = sum(abs(clock(:)).^2)/length(clock(:));
Power_n = sum(abs(noise(:)).^2)/length(noise(:));

% euresh klimakas ypoba8mishs vash tou epi8umhtou 8oryvou
scale_fact = (Power_s/Power_n)*10^(-SNR/10);

% telikos epi8ymhtos 9oryvos pou prosti8etai sthn eikona
noise_fin = sqrt(scale_fact)*noise;

% eikona me 8oryvo
white_clock = clock + noise_fin;

%% DFT noisy img and noise


% ypologismos ths arxikhs grammhs omega
for i = 1:x
    omega(1,i) = exp((-2*pi*1i/x)*(i-1));
end

% ypswnontas to omega sthn i-1 epitygxanetai h morfh toy mhtrwou pou
% zhteitai
for i = 1:x
    W(i,:) = omega.^(i-1);
end

% kanonikopoihsh tou W diairontas me to sqrt(N)
W = (1/sqrt(x))*W;

% DFT ths eikonas
clock_new = W*white_clock*W';

% DFT tou 8oryvou
pn1 = W*noise_fin*W';

%% efarmogh ths texnikhs gia wiener filtering

% briskoume th pyknothta fasmatos tou noisy image
mpl = (abs(clock_new).^2)./y^2;

% =============================================================== %
% edw briskoume to Pn (pyknothta fasmatos tou 8oryvou) 8ewrontas ton
% agnwsto. briskoume th mesh timh apo ena para8yro pou scannarei thn
% pyknothta fasmatos isxyos ths eikonas (makrya apo tis gwnies kai akres pou
% yparxoun oi xamhles syxnothtes kai thn apo8hkeuoume se ena dianysma. meta
% apo auto to dianysma briskoume pali mia mesh timh gia na eimaste oso pio
% konta mporoume se ena "kalo mean"
pn = [];
block = 40;
for i = block:y-block
    for j = block:y-block
        gia_pn = mpl(i:i+(block-1),j:j+(block-1));
        pn(numel(pn)+1,1) = sum(gia_pn(:))/length(gia_pn(:));
    end
end
pn = sum(pn)/length(pn);

% dhmiourgoume ena pinaka sto mege8os ths eikonas me ka8e timh tou ish me
% to pn pou brhkame
pn = pn*ones(y);

% edw xrhsimopoioume kai to gnwsto 8orybo gia to 1o ypoerwthma tou A merous
pn1 = abs(pn1).^2/y^2;

% pn1 = abs(pn1);
% briskoume ena pf gia ton agnwsto 8orybo
pf = abs(mpl-pn);

% ena pf gia to gnwsto 8oryvo
pf1 = abs(mpl-pn1);

% briskoume to H filtro gia ton agnwsto 8oryvo
H = pf./(pf+pn);

% to H1 gia ton gnwsto 8oryvo
H1 = pf1./(pf1+pn1);

% polzoume to DFT tou noisy image me to ena H kai sth synexeia me to allo
wie = (clock_new).*(H);
wie1 = (clock_new).*(H1);

% sth synexeia sta figures kanoume th pra3h gia ton antistrofo DFT wste na
% mporesoume na doume to apotelesma
figure,subplot(1,3,1),imshow(white_clock),title('noisy image')
subplot(1,3,2),imshow(real(inv(W)*wie1*inv(W'))),title('filtro me gnwsto noise')
subplot(1,3,3),imshow(real(inv(W)*wie*inv(W'))),title('filtro me noise para8yrou')
