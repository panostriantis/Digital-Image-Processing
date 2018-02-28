%% synarthsh pou kanei ena epi8ymhto padding sthn eikona (gray scale)
% h synarthsh kanei padding tis idies sthles kai grammes giati auto
% xreiazotan sta plaisia ths askhshs
% input : img (eikona gia padding), lines2pad (grammes pou 8a proste8oun
% perimetrika sthn eikona)
% output : padded_img (eikona e3odou)
function [padded_img] = padding_mirror(img,lines2pad)
% elegxos gia th "trith" diastash ths eikonas
% an einai to d megalytero apo 1 tote th kanoume rgb2gray
[x,y,d] = size(img);
if d~=1
    img = rgb2gray(img);
end
% epilogh grammwn me bash to padding pou 8eloume gia padding se sthles
x_dim_start = img(:,1:lines2pad);
x_dim_end = img(:,y-(lines2pad-1):y);

% concatenating me thn eikona afou antistrafoun oi sthles (mirror)
padded_img_x = [fliplr(x_dim_start) img fliplr(x_dim_end)];
% arxikopoihsh endiameswn mege8wn gia na ginei padd kai stis grammes
[x_p,y_p] = size(padded_img_x);
% xrhsh idias me8odou me parapanw
y_dim_start = padded_img_x(1:lines2pad,:);
y_dim_end = padded_img_x(x_p-(lines2pad-1):x_p,:);

padded_img = [flipud(y_dim_start); padded_img_x; flipud(y_dim_end)];
end