%% meros_C (filtra Notch)
% script pou dhmiourgeitai to filtro notch na antimetwpistei o 8oryvos twn
% aktinografiwn sth syxnothta sta shmeia opou parousiazetai akrivws

close all; clear all; clc

%% radiograph_1
% akolou8eitai h idia diadikasia gia to metasxhmatismo Fourier kai ton 
% antistrofo metasxhmatismo sth synexeia
% padding ths eikonas me mhdenika
radio_1 = fft_pad(im2double(imread('radiograph_1.jpg')));
[xr1,yr1] = size(radio_1);
% fft kata grammes - sthles
for i = 1:xr1
    fft_grammes_r1(i,:) = fft(radio_1(i,:));
end

for i = 1:yr1
    fft_sthles_r1(:,i) = fft(fft_grammes_r1(:,i));
end

radio_1_fft2 = shift(fft_sthles_r1);

sigma = 2*25.6;
posit_r1_x = 2*[-95 -45 45 95];
posit_r2_y = 2*[10 5 -5 -10];

for metav = 1:4
    omega_x_r1 = (xr1+1)/2;
    omega_y_r1 = (yr1+1)/2;
    omega_x_r1 = omega_x_r1 + posit_r1_x(metav);
    omega_y_r1 = omega_y_r1 + posit_r2_y(metav);
    for i = 1:xr1
        for j = 1:yr1
            H_r1{metav}(i,j) = (1-exp(-((omega_x_r1 - i)^2 +...
                (omega_y_r1 - j)^2)/sigma^2));
        end
    end
end
% ypologismos tou telikou filtrou gia ka8e shmeio opou parousiazetai
% paramorfwsh sto fasma twn syxnothtwn
h_r1 = H_r1{1}.*H_r1{2}.*H_r1{3}.*H_r1{4};
new_radio_1 = (h_r1).*radio_1_fft2;

figure
subplot(1,3,1),imshow(log10(abs(radio_1_fft2))-1.35),title('arxiko fasmatiko periexomeno')
subplot(1,3,2),imshow(h_r1),title('filtro Notch')
subplot(1,3,3),imshow(log10(abs(new_radio_1))-1.35),title('periexomeno meta to filtro')

new_radio_1 = inverse_shift(new_radio_1);
% ifft kata grammes - sthles
for i = 1:xr1
    ifft_grammes_r1(i,:) = ifft(new_radio_1(i,:));
end

for i = 1:yr1
    ifft_sthles_r1(:,i) = ifft(ifft_grammes_r1(:,i));
end
% epanafora ths eikonas sto arxiko ths mege9os
teliko_r1 = inverse_pad(ifft_sthles_r1);

figure
subplot(1,2,1),imshow(inverse_pad(radio_1)),title('arxikh')
subplot(1,2,2),imshow(teliko_r1),title('filtrarismenh eikona')


%% radiograph_2
% akolou8eitai h idia diadikasia me thn 1h aktinografia mono pou edw
% dhmiourgountai 2 filtra mono giati ta shmeia pou 8eloume na e3aleipsoume
% einai 2
radio_2 = fft_pad(im2double(imread('radiograph_2.jpg')));

[xr2,yr2] = size(radio_2);
% fft
for i = 1:xr2
    fft_grammes_r2(i,:) = fft(radio_2(i,:));
end

for i = 1:yr2
    fft_sthles_r2(:,i) = fft(fft_grammes_r2(:,i));
end

radio_2_fft2 = shift(fft_sthles_r2);

sigma_r2 = 2*17.6;
posit_r2_x = 2*[9 -9];
posit_r2_y = 2*[-35 35];

for metav = 1:length(posit_r2_x)
    omega_x_r2 = (xr2+1)/2;
    omega_y_r2 = (yr2+1)/2;
    omega_x_r2 = omega_x_r2 + posit_r2_x(metav);
    omega_y_r2 = omega_y_r2 + posit_r2_y(metav);
    for i = 1:xr2
        for j = 1:yr2
            H_r2{metav}(i,j) = (1-exp(-((omega_x_r2 - i)^2 +...
                (omega_y_r2 - j)^2)/sigma_r2^2));
        end
    end
end

h_r2 = H_r2{1}.*H_r2{2};
new_radio_2 = (h_r2).*radio_2_fft2;

figure
subplot(1,3,1),imshow((log10(abs(radio_2_fft2))-1.35)),title('arxiko fasmatiko periexomeno')
subplot(1,3,2),imshow(h_r2),title('filtro Notch')
subplot(1,3,3),imshow(abs((new_radio_2))/100),title('periexomeno meta to filtro')

new_radio_2 = inverse_shift(new_radio_2);
% ifft
for i = 1:xr2
    ifft_grammes_r2(i,:) = ifft(new_radio_2(i,:));
end

for i = 1:yr2
    ifft_sthles_r2(:,i) = ifft(ifft_grammes_r2(:,i));
end
teliko_r2 = inverse_pad(ifft_sthles_r2);

figure
subplot(1,2,1),imshow(inverse_pad(radio_2)),title('arxikh')
subplot(1,2,2),imshow(teliko_r2),title('filtrarismenh eikona')
