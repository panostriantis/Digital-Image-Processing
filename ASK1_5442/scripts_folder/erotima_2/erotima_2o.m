%% 2o_erotima apotelesmata gia 4 & 6 epipeda kvantishs se ka8e xrwma

close all; clear all; clc

peppers = imread('pepper.jpg');

L_4 = 4;
L_6 = 6;

peppers_4_lvls = img_quant(peppers,L_4,L_4,L_4);

peppers_6_lvls = img_quant(peppers,L_6,L_6,L_6);

%% SNR
% afairontas apo thn arxikh eikona th kvantismenh briskoume to 8orybo
noise_4_lvls = peppers - peppers_4_lvls;

noise_6_lvls = peppers - peppers_6_lvls;

% briskoume thn isxy tou shmatos (eikonas) kai twn 8oryvwn
power_pepp = sum(abs(peppers(:).^2))/length(peppers(:));

power_n_4 = sum(abs(noise_4_lvls(:).^2))/length(noise_4_lvls(:));

power_n_6 = sum(abs(noise_6_lvls(:).^2))/length(noise_6_lvls(:));

% ypologismos tou SNR kvantismenwn eikonwn
SNR_4 = 10*log10(power_pepp/power_n_4);

SNR_6 = 10*log10(power_pepp/power_n_6);

%% figures
% panw sth kvantimsenh eikona anagrafetai kai to SNR me akriveia 3 pshfiwn
str_4 = sprintf('4 level, SNR: %.3f',SNR_4);
str_6 = sprintf('6 level, SNR: %.3f',SNR_6);
subplot(1,3,1),subimage(peppers),title('arxikh')
subplot(1,3,2),subimage(peppers_4_lvls),title(str_4)
subplot(1,3,3),subimage(peppers_6_lvls),title(str_6)
