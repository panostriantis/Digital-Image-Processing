%% function inverse_shift
% synarthsh pou xrhsimopoieitai gia antistrofh ths shift synartshs gia na
% ginei o antistrofos fourier swsta
function [new_img] = inverse_shift(img)

[x,y,d] = size(img);
if d>1
    error('only m (x) n (x) 1 images');
    return;
end
if rem(x,2)==0 && rem(y,2)==0
    % diairesh eikonas se 4 kommatia
    fst_q = img(1:(x/2),1:(y/2));
    scd_q = img(1:(x/2),(y/2)+1:y);
    thd_q = img((x/2)+1:x,1:(y/2));
    fth_q = img((x/2)+1:x,(y/2)+1:y);
elseif rem(x,2)~=0 && rem(y,2)~=0
    fst_q = img(1:ceil(x/2),1:ceil(y/2));
    scd_q = img(1:ceil(x/2),ceil(y/2)+1:y);
    thd_q = img(ceil(x/2)+1:x,1:ceil(y/2));
    fth_q = img(ceil(x/2)+1:x,ceil(y/2)+1:y);
elseif rem(x,2)~=0 && rem(y,2)==0
    fst_q = img(1:ceil(x/2),1:(y/2));
    scd_q = img(1:ceil(x/2),(y/2)+1:y);
    thd_q = img(ceil(x/2)+1:x,1:(y/2));
    fth_q = img(ceil(x/2)+1:x,(y/2)+1:y);
elseif rem(x,2)==0 && rem(y,2)~=0
    fst_q = img(1:(x/2),1:ceil(y/2));
    scd_q = img(1:(x/2),ceil(y/2)+1:y);
    thd_q = img((x/2)+1:x,1:ceil(y/2));
    fth_q = img((x/2)+1:x,ceil(y/2)+1:y);
end

% synenwsh twn kommatiwn
new_img = [fth_q thd_q;
    scd_q fst_q];

end