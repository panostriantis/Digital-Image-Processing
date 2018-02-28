%% 4o_erotima B
% padding twn eikonwn me th me8odo antikatoptrismou twn akrwn tous

close all; clear all; clc
building = im2double(imread('building.jpg'));
building_5x5 = padding_mirror(building,2);

train = im2double(imread('train.jpg'));
train_5x5 = padding_mirror(train,2);

% arxikopoihsh mege8wn
[x_b5,y_b5] = size(building_5x5);
[x_t5,y_t5] = size(train_5x5);

% dhmiourgia tou pinaka pou mas dothike
filt = [0 1 1 1 0];
filt = [filt; filt+1; filt+1; filt+1; filt];
filt(3,3) = 2*filt(3,3);
% metatroph tou se dianysma gia na efarmostei sth synexeia me vash th
% me8odo pou akolou8oume
filt = filt(:);

for i = 3:x_b5-2
    fprintf('building - eimaste sth grammh: %d\n',i);
    for i1 = 3:y_b5-2
        % dialegoume apo thn eikona ena para8yro 5x5
        A5 = building_5x5(i-2:i+2,i1-2:i1+2);
        % to kanoume dianysma
        A5 = A5(:);
        % arxikopoioume ena dianysma gia na apo8hkeusoume ta stoixeia meta
        % thn efarmogh ths me8odou wste na diale3oume to katallhlo
        n = [];
        % ousiastika epanalamvanoyme ta stoixeia tou 5x5 para8yrou gia oses
        % 8eseis ypodeikyei to filtro mas
        for j = 1:length(A5)
            rep(j,1) = A5(j);
            num = numel(n);
            n(num+1:num+filt(j)) = rep(j,1);
        end
        % sort tou dianysmatos
        n = sort(n);
        % epilogh tou mesaiou stoixeiou tou dianysmatos, sth periptwsh mas
        % h if xreiazetai mono to prwto meros afou to sum tou filtrou einai
        % iso me 32 ara epilegoume to (16o+17o)/2 alliws an to sum htan
        % monos ari8mos 8a epilegotan to (((sum-1)/2) + 1)
        if rem(length(n),2) == 0
            building_5x5_n(i-2,i1-2) = (n(floor(length(n)/2))+n(ceil(length(n)/2)))/2;
        elseif rem(length(n),2)~=0
            building_5x5_n(i-2,i1-2) = n(ceil(length(n)/2));
        end
    end
end

% akolou8eitai h idia diadikasia me parapanw
for i = 3:x_t5-2
    fprintf('train - eimaste sth grammh: %d\n',i);
    for i1 = 3:y_t5-2
        B5 = train_5x5(i-2:i+2,i1-2:i1+2);
        B5 = B5(:);
        n = [];
        for j = 1:length(B5)
            rep(j,1) = B5(j);
            num = numel(n);
            n(num+1:num+filt(j)) = rep(j,1);
        end
        n = sort(n);
        if rem(length(n),2) == 0
            train_5x5_n(i-2,i1-2) = (n(floor(length(n)/2))+n(ceil(length(n)/2)))/2;
        elseif rem(length(n),2)~=0
            train_5x5_n(i-2,i1-2) = n(ceil(length(n)/2));
        end
    end
end

figure,subplot(1,2,1),imshow(building),title('arxikh')
subplot(1,2,2),imshow(building_5x5_n),title('5x5 me varh')
figure,subplot(1,2,1),imshow(train),title('arxikh')
subplot(1,2,2),imshow(train_5x5_n),title('5x5 me varh')