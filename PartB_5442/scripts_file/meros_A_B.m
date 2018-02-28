%% meros_A_B (apeikonish 2D Fourier & filtra Butterworth)
% script pou ginetai o 2D metasxhmatismos Fourier kai 
% dhmiourgountai ta filtra butterworth (ypsiperata kai xamhloperata)
% gia na antimetwpistei o 8oryvos twn aktinografiwn sth syxnothta
close all; clear all; clc

%% radiograph_1
% prwth aktinografia
% diplasiasmos twn diastasewn ths eikonas gia na ginei o fourier kai na
% syneli3oume sth syxnothta kai meta epanafora sta arxika mege8h sto telos
radio_1 = fft_pad(im2double(imread('radiograph_1.jpg')));

[xr1,yr1] = size(radio_1);
% didiastatos fft me th me9odo grammwn sthlwn
for i = 1:xr1
    fft_grammes_r1(i,:) = fft(radio_1(i,:));
end

for i = 1:yr1
    fft_sthles_r1(:,i) = fft(fft_grammes_r1(:,i));
end
% shift sta epimerous kommatia gia na feroume sto (0,0) tis syxnothtes
radio_1_fft2 = shift(fft_sthles_r1);

figure
subplot(1,2,1),imshow(inverse_pad(radio_1)),title('arxikh kranio')
subplot(1,2,2),imshow((log10(abs(radio_1_fft2))-1.35)),title('DFT')

% epilogh twn omega kai rank gia toys typous twn filtrwn
omega_l_r1 = 65.5;
omega_h_r1 = 199.5;
for repeat = 0:7
    ran_f = 1+repeat;

    for i = 1:xr1
        for j = 1:yr1
            % xamhloperato filtro
            Low_H_r1(i,j) = 1/(1+(sqrt(((i-((xr1+1)/2)).^2)+((j-((yr1+1)/2)).^2))/omega_l_r1).^(2*ran_f));
            % ypsiperato filtro
            High_H_r1(i,j) = 1/(1+(omega_h_r1./sqrt(((i-((xr1+1)/2)).^2)+((j-((yr1+1)/2)).^2))).^(2*ran_f));
        end
    end
    % syneli3h sth syxnnothta pol/zontas stoixeio epi stoixeio
    new_radio_1 = (Low_H_r1+High_H_r1).*radio_1_fft2;
    figure
    subplot(1,2,1),imshow(log10(abs(radio_1_fft2))-1.35),title('arxiko fasmatiko periexomeno')
    subplot(1,2,2),imshow(log10(abs(new_radio_1))-1.35),title(sprintf('periexomeno meta apo filtro ta3hs: %d',ran_f))
    new_radio_1 = inverse_shift(new_radio_1);
    % antistrofos fft kata grammes kai kata sthles gia na paroume thn arxikh
    % eikona mas
    for i = 1:xr1
       ifft_grammes_r1(i,:) = ifft(new_radio_1(i,:));
    end

    for i = 1:yr1
        ifft_sthles_r1(:,i) = ifft(ifft_grammes_r1(:,i));
    end
    teliko_r1 = inverse_pad(ifft_sthles_r1);

    figure
    subplot(1,2,1),imshow(inverse_pad(radio_1)),title('arxikh')
    subplot(1,2,2),imshow(teliko_r1),title(sprintf('filtrarismenh me filtro ta3hs: %d',ran_f))
end

%% radiograph_2
% deuterh aktinografia - kai edw akolou8eitai h idia me8odos me parapanw
radio_2 = fft_pad(im2double(imread('radiograph_2.jpg')));

[xr2,yr2] = size(radio_2);

for i = 1:xr2
    fft_grammes_r2(i,:) = fft(radio_2(i,:));
end

for i = 1:yr2
    fft_sthles_r2(:,i) = fft(fft_grammes_r2(:,i));
end

radio_2_fft2 = shift(fft_sthles_r2);

figure
subplot(1,2,1),imshow(inverse_pad(radio_2)),title('arxikh gonato')
subplot(1,2,2),imshow((log10(abs(radio_2_fft2))-1.35)),title('DFT')

omega_l_r2 = 52.5;
omega_h_r2 = 112;
for repeat = 0:4
    ran_f = 1+repeat;

    for i = 1:xr2
        for j = 1:yr2
            % xamhloperato filtro
            Low_H_r2(i,j) = 1/(1+(sqrt(((i-((xr2+1)/2)).^2)+((j-((yr2+1)/2)).^2))/omega_l_r2).^(2*ran_f));
            % ypsiperato filtro
            High_H_r2(i,j) = 1/(1+(omega_h_r2./sqrt(((i-((xr2+1)/2)).^2)+((j-((yr2+1)/2)).^2))).^(2*ran_f));
        end
    end

    new_radio_2 = (Low_H_r2+High_H_r2).*radio_2_fft2;

    figure
    subplot(1,2,1),imshow(log10(abs(radio_2_fft2))-1.35),title('arxiko fasmatiko periexomeno')
    subplot(1,2,2),imshow(log10(abs(new_radio_2))-1.35),title(sprintf('periexomeno meta apo filtro ta3hs: %d',ran_f))
    new_radio_2 = inverse_shift(new_radio_2);

    for i = 1:xr2
        ifft_grammes_r2(i,:) = ifft(new_radio_2(i,:));
    end

    for i = 1:yr2
        ifft_sthles_r2(:,i) = ifft(ifft_grammes_r2(:,i));
    end
    teliko_r2 = inverse_pad(ifft_sthles_r2);
    figure
    subplot(1,2,1),imshow(inverse_pad(radio_2)),title('arxikh')
    subplot(1,2,2),imshow(teliko_r2),title(sprintf('filtrarismenh me filtro ta3hs: %d',ran_f))
end