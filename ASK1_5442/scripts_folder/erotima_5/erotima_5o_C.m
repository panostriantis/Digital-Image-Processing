%% 5o_erotima_C

% efarmogh ths e3iswshs istogrammatos topika sthn eikona
close all; clear all; clc
% metablhtes pou ry8mizoun to para8yro kai to padding pou 8a xreiastei gia
% to para8yro pou 8a xrhsimopoih8ei wste na automatopoieitai h diadikasia
para8yro = 71;
orio = floor(para8yro/2);

d_road_1 = (im2double(imread('dark_road_1.jpg')));
d_road_2 = (im2double(imread('dark_road_2.jpg')));
d_road_3 = (im2double(imread('dark_road_3.jpg')));

% padding me th synarthsh mas gia reflection-mirror padding
d_road_1 = padding_mirror(d_road_1,orio);
d_road_2 = padding_mirror(d_road_2,orio);
d_road_3 = padding_mirror(d_road_3,orio);

% arxikopoihsh mege8wn
[x1,y1] = size(d_road_1);
[x3,y3] = size(d_road_3);

% meros opou pragmatopoieitai o kwdikas gia thn e3iswsh istogrammatos
% oi 2 eikones exoun to idio mege8os opote exoun mpei sto idio loop
for x = (orio+1):x1-orio
    fprintf('eimaste sth grammh : %d\n',x);
    for y = (orio+1):y1-orio
        % epilogh tou para8yrou ka8e eikonas pou 8eloume na kanoyme e3iswsh
        % istogrammatos
        A = d_road_1(x-orio:x+orio,y-orio:y+orio);
        B = d_road_2(x-orio:x+orio,y-orio:y+orio);
        % sto j kai j1 apo8hkeuontai ta kentrika shmeia tou
        % para8yrou(ennoeitai to para8yro einai perittos 3,5,7)
        j = A(orio+1,orio+1);
        j1 = B(orio+1,orio+1);
        % arxikopoihsh dianysmatwn pou periexoun th timh, th pi8anothta
        % emfanishs ka8e timhs sto sygkekrimeno para8yro
        a = [];
        b = [];
        % briskoume tis monadikes times pou yparxoun sto para8yro kai
        % metrame poses fores emfanizontai me th xrhsh twn for
        a(:,1) = unique(A);
        b(:,1) = unique(B);
        for i = 1:length(a(:))
            t = a(i,1);
            a(i,2) = numel(find(A==t));
            a(i,2) = (a(i,2)./length(A(:)));
            % elegxoume an h timh(syxnothta) pou briskoume th pi8anothta
            % einai idia me th timh(syxnothta) tou kentrikou shmeiou tou
            % para8yrou. an einai idia tote briskoume to cumulative sum
            % dhladh th swreumenh pi8anothta se ekeino to shmeio kai
            % pol/zoume me to 255 gia na vroume th nea syxnothta tou shmeiou
            if t == j
                % edw yparxei kai h dynatothta na ginei se uint8 h eikona
                % alla den exei diafora apo th double ta apotelesmata einai
                % idia
                % d_road_n1(x-orio,y-orio) = floor(255*sum(a(1:i,2)));
                d_road_n1(x-orio,y-orio) = sum(a(1:i,2));
                break
            end
        end
        % ginetai h idia diadikasia me parapanw
        for i = 1:length(b(:))
            t1 = b(i,1);
            b(i,2) = numel(find(B==t1));
            b(i,2) = (b(i,2)./length(B(:)));
            if t1 == j1
                d_road_n2(x-orio,y-orio) = sum(b(1:i,2));
                % edw yparxei kai h dynatothta na ginei se uint8 h eikona
                % alla den exei diafora apo th double ta apotelesmata einai
                % idia
                % d_road_n2(x-orio,y-orio) = floor(255*sum(b(1:i,2)));
                break
            end
        end
    end
end
% ginetai h idia diadikasia pou perigrafhke gia tis prohgoumenes dyo
% eikones
for x = (orio+1):x3-orio
    fprintf('eimaste sth grammh : %d\n',x);
    for y = (orio+1):y3-orio
        A = d_road_3(x-orio:x+orio,y-orio:y+orio);
        j = A(orio+1,orio+1);
        a = [];
        a(:,1) = unique(A);
        for i = 1:length(a(:))
            t = a(i,1);
            a(i,2) = numel(find(A==t));
            a(i,2) = (a(i,2)./length(A(:)));
            if t == j
                % d_road_n3(x-orio,y-orio) = floor(255*sum(a(1:i,2)));
                d_road_n3(x-orio,y-orio) = sum(a(1:i,2));
                break
            end
        end
    end
end
%% ta imshow gia ta apotelesmata mas

figure,imshow((d_road_n1)),figure,imshow((d_road_n2)),figure,imshow((d_road_n3))
figure,subplot(1,2,1),imshow(d_road_n1),subplot(1,2,2),imhist(d_road_n1)
figure,subplot(1,2,1),imshow(d_road_n2),subplot(1,2,2),imhist(d_road_n2)
figure,subplot(1,2,1),imshow(d_road_n3),subplot(1,2,2),imhist(d_road_n3)


% imshow pou mporoyn na xrhsimopoih8oun an ginei xrhsh ths metatrophs twn
% apotelesmatwn sto pedio tou uint8 (0:255)
% figure,imshow(uint8(d_road_n1)),figure,imshow(uint8(d_road_n2)),figure,imshow(uint8(d_road_n3))
% figure,subplot(1,2,1),subimage(uint8(d_road_n1)),subplot(1,2,2),imhist(uint8(d_road_n1))
% figure,subplot(1,2,1),subimage(uint8(d_road_n2)),subplot(1,2,2),imhist(uint8(d_road_n2))
% figure,subplot(1,2,1),subimage(uint8(d_road_n3)),subplot(1,2,2),imhist(uint8(d_road_n3))
