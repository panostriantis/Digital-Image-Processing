%% ellipsoid_filter
% xamhloperata kai ypsiperata filtra alla me elleipsoeides sxhma
% einai ta idia filtra me ta butterworth apla anti gia kyklo dhmiourgh8hke
% elleipsh panw stous a3ones logw ths katanomhs tou 8oryvou etsi wste na
% epiteux8ei ligoterh apwleia plhroforias kata thn efarmogh toy filtrou.
% sto typo tou filtrou anti na mpei h synarthsh gia to kyklo (x^2 , y^2)
% diaire8hke me kapoies metavlhtes gia na dhmiourgh8oun oi elleipseis
close all; clear all; clc

%% radiograph_1

radio_1 = fft_pad(im2double(imread('radiograph_1.jpg')));

[xr1,yr1] = size(radio_1);

for i = 1:xr1
    fft_grammes_r1(i,:) = fft(radio_1(i,:));
end

for i = 1:yr1
    fft_sthles_r1(:,i) = fft(fft_grammes_r1(:,i));
end

radio_1_fft2 = shift(fft_sthles_r1);

omega_l_r1 = 47.5;
omega_h_r1 = 90;
ran_f = 5;

for i = 1:xr1
    for j = 1:yr1
        % xamhloperato me diairemeno to x^2 kai y^2 me mia sta8era
        Low_H_r1(i,j) = 1/(1+(sqrt(((i-(xr1/2)).^2)/2+((j-(yr1/2)).^2)/6)/omega_l_r1).^(2*ran_f));
        % ypsiperato me diairemeno to x^2 kai y^2 me mia sta8era
        High_H_r1(i,j) = 1/(1+(omega_h_r1./sqrt(((i-(xr1/2)).^2)/6+((j-(yr1/2)).^2)/.45)).^(2*ran_f));
    end
end

new_radio_1 = (Low_H_r1+High_H_r1).*radio_1_fft2;

figure
subplot(1,3,1),imshow(log10(abs(radio_1_fft2))-1.35),title('arxiko fasmatiko periexomeno')
subplot(1,3,2),imshow(Low_H_r1+High_H_r1),title('filtro')
subplot(1,3,3),imshow(log10(abs(new_radio_1))-1.35),title('periexomeno meta to filtro')

new_radio_1 = inverse_shift(new_radio_1);

for i = 1:xr1
    ifft_grammes_r1(i,:) = ifft(new_radio_1(i,:));
end

for i = 1:yr1
    ifft_sthles_r1(:,i) = ifft(ifft_grammes_r1(:,i));
end

teliko_r1 = inverse_pad(ifft_sthles_r1);

figure
subplot(1,2,1),imshow(inverse_pad(radio_1)),title('arxikh')
subplot(1,2,2),imshow(teliko_r1),title('filtrarismenh')


%% radiograph_2

% akolou8eitai h idia diadikasia kai edw

radio_2 = fft_pad(im2double(imread('radiograph_2.jpg')));

[xr2,yr2] = size(radio_2);

for i = 1:xr2
    fft_grammes_r2(i,:) = fft(radio_2(i,:));
end

for i = 1:yr2
    fft_sthles_r2(:,i) = fft(fft_grammes_r2(:,i));
end

radio_2_fft2 = shift(fft_sthles_r2);
ran_f = 5;
omega_l_r2 = 25;
omega_h_r2 = 80;
for i = 1:xr2
    for j = 1:yr2
        Low_H_r2(i,j) = 1/(1+(sqrt(((i-((xr2+1)/2)).^2)/2+((j-((yr2+1)/2)).^2)/1.35)/omega_l_r2).^(2*ran_f));
        High_H_r2(i,j) = 1/(1+(omega_h_r2./sqrt(((i-((xr2+1)/2)).^2)/0.2+((j-((yr2+1)/2)).^2)/1.2)).^(2*ran_f));
    end
end

new_radio_2 = (Low_H_r2+High_H_r2).*radio_2_fft2;

figure
subplot(1,3,1),imshow(log10(abs(radio_2_fft2))-1.35),title('arxiko fasmatiko periexomeno')
subplot(1,3,2),imshow(Low_H_r2+High_H_r2),title('filtro')
subplot(1,3,3),imshow(log10(abs(new_radio_2))-1.35),title('periexomeno meta to filtro')

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
subplot(1,2,2),imshow(teliko_r2),title('filtrarismenh')
