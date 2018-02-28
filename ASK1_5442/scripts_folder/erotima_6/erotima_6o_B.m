%% 6o_erotima_B

close all; clear all; clc

clock = im2double(rgb2gray(imread('clock.jpg')));

% kanoume tetragwniko to clock
clock = imresize(clock,[301 301]);
[x,y] = size(clock);

% xrhsimopoioume to psf kai pairnoume thn e3odo
psf_clock = psf(clock);

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

% DFT ths eikonas e3odou tou psf
ft_psf_clock = W*psf_clock*W';

% DFT ths kanonikhs eikonas
ft_clock = W*clock*W';

% synarthsh metaforas brisketai sth syxnothta diairontas to fourirer ths
% e3odou me to fourier ths eisodou
Hf = (ft_psf_clock)./(ft_clock);

% h kroustikh apokrish einai o antistrofos fourier ths synarthshs metaforas
hf = inv(W)*(Hf)*inv(W');

% plot ths Hf kai hf
figure,subplot(2,1,1),plot(real(Hf(:))),title('synarthsh metaforas')
subplot(2,1,2),plot(real(hf(:))),title('kroustikh apokrish')

figure,imshow(Hf),title('apeikonish synarthshs metaforas')

% B iso me th synarthsh metaforas gia euresh tou antistrofou filtrou
B = Hf(:);

% ena gamma pou xrhsimopoioume gia th kawfliwsh
gamma_vect = [0.8, 1.2, 4];
for repeat = 1: length(gamma_vect);
    gamma = gamma_vect(repeat);
    for i = 1:length(B)
        if gamma > 1/abs(B(i))
            H{repeat}(i,1) = 1/B(i);
        elseif gamma <= 1/abs(B(i))
            H{repeat}(i,1) = (gamma*abs(B(i)))/B(i);
        end
    end
end

for rep = 1:repeat
    % H to teliko antistrofo filtro mas
    H_loc = reshape(H{rep},size(Hf,1),size(Hf,2));

    % edw sth syxnothta efarmozetai to filtro sth 
    wie = ft_psf_clock.*H_loc;

    teliko = inv(W)*(wie)*inv(W');

    % syneli3h - pol/mos sth syxnothta ths eikonas e3odou tou psf me th 1 pros
    % ths synarthsh metaforas 1/Hf
    antistrofo_mono = real(inv(W)*((1./Hf).*ft_psf_clock)*inv(W'));

    mse(rep) = mean((clock(:) - real(teliko(:))).^2);

    str{rep} = sprintf('me katwfli: %.1f ,mse: %d', gamma_vect(rep), mse(rep));

    %% figures gia ka8e timh katwfliou, nagrafetai panw sthn eikona to
    % katwfli kai to mean square error
    figure(2+rep)
    subplot(2,2,1),imshow(clock),title('arxiko')
    subplot(2,2,2),imshow(psf_clock/5),title('clock meta apo psf')
    subplot(2,2,3),imshow(antistrofo_mono),title('aplh syneli3h me antistrofo')
    subplot(2,2,4),imshow(real(teliko)),title(str{rep})
end