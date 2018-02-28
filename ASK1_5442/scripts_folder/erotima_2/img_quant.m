%% synarthsh kvantismou egxrwmhs (rgb) eikonas
% output: quantized_img(kvantismenh eikona)
% input: rgb_img(eikona pros kvantish)
% L1 -> epipeda kvantishs sto red
% L2 -> epipeda kvantishs sto green
% L3 -> epipeda kvantishs sto blue

function [quantized_img] = img_quant(rgb_img,L1,L2,L3)
% arxikopoihsh mege8wn
[x,y,f] = size(rgb_img);

for i = 1:f
    if i == 1
        epipeda = L1;
        fprintf('quantization on red scale');
    elseif i == 2
        epipeda = L2;
        fprintf('quantization on green scale');
    elseif i == 3
        epipeda = L3;
        fprintf('quantization on blue scale');
    end
    % dhmiourgia cell pou exei to red, green, blue se 3exwristous pinakes
    im{i} = rgb_img(:,:,i);
    % metatroph se dianysma
    im2 = im{i}(:);
    % metatroph tou megistou se double gia na mporesoume na epe3ergastoume
    % kai na kanoume pra3eis
    x_max = double(max(im{i}(:)));
    % to idio kai gia to min
    x_min = double(min(im{i}(:)));
    % briskoume to bhma kvantishs
    D = ((x_max-x_min)/(epipeda));
    % loop gia ypologismo twn akrwn sth kvantish to prwto einai iso me to
    % min
    a(1) = x_min;
    for j = 1:epipeda+1
        a(j) = uint8((j-1)*D);
    end
    % provolh dianysmatos akrwn sto workspace
    display(a)
    % euresh kentrwn
    for m = 1:epipeda
        centers(m)=(a(m)+a(m+1))/2;
    end
    % provolh kentrwn sto ws
    display(centers)
    % edw ginetai h kvantish trexontas to pinaka san dianysma pou to
    % metatrepsame parapanw
    xlen = length(im2);
    for n = 1:xlen
        % dhmiourgia flag gia thn while kai enos metrhth kl pou kineitai
        % mesa sto dianysma pou periexei ta akra gia th kvantish kai meta
        % epe3ergazomaste to ka8e stoixeio
        flag = true;
        kl = 1;
        while(flag)
            % kvantish twn stoixeiwn analogws me th timh ths syxnothtas
            % tous
            if(im2(n) <= a(kl+1))&& (im2(n) <= centers(kl))
                quantized{i}(n) = uint8(a(kl));
                flag = false;
            elseif (im2(n) <= a(kl+1))&& (im2(n) >= centers(kl))
                quantized{i}(n) = uint8(a(kl+1));
                flag = false;
            else
                kl = kl+1;
            end
        end
    end
end
% enwsh twn rgb se mia eikona kai metasxhmatismos stis diastaseis ths
% arxikhs eikonas
quantized_img = [quantized{1} quantized{2} quantized{3}];
quantized_img = reshape(quantized_img,x,y,f);
end