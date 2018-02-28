%% 3o_erotima - anixneush akmwn

close all; clear all; clc

factory = rgb2gray(im2double(imread('factory.jpg')));
% mirror padding gia efarmogh tou para8yrou se ola ta pixel
factory = padding_mirror(factory,1);
% arxikopoihsh mege8wn
[x,y,~] = size(factory);

% dhmiourgia maskwn pou exoun didax8ei sto ma8hma
Sobel_G_x = [-1 0 1; -2 0 2; -1 0 1];
Sobel_G_y = Sobel_G_x';
Sobel_diag_1 = [0 1 2; -1 0 1; -2 -1 0];
Sobel_diag_2 = Sobel_diag_1';
Prewitt_G_x = [-1 0 1; -1 0 1; -1 0 1];
Prewitt_G_y = Prewitt_G_x';
Prewitt_diag_1 = [0 1 1; -1 0 1; -1 -1 0];
Prewitt_diag_2 = Prewitt_diag_1';

% euresh 2 katwfliwn gia thn apeikonish twn akmwn me bash th mesh timh twn
% syxnothtwn ths eikonas (ena katwfli gia iso me th mesh timh kai ena iso
% me th 3/2 ths meshs timhs)
T = mean(factory(:));
oliko = T;
oliko1 = 3*T/2;
% efarmozetai didiastath syneli3h toy para8yrou pou kineitai mesa sthn
% eikona me tis maskes kai meta ginetai epilogh ths megalyterhs e3odou
% autwn twn maskwn
for i = 2:x-1
    fprintf('eimaste sth grammh: %d\n',i);
    for i1 = 2:y-1
        A = factory(i-1:i+1,i1-1:i1+1);
%         t = mean(A(:));
%         topiko = 5*t/4;
        sobel_x = conv2(A,Sobel_G_x,'same');
        sobel_y = conv2(A,Sobel_G_y,'same');
        sobel_diag_1 = conv2(A,Sobel_diag_1,'same');
        sobel_diag_2 = conv2(A,Sobel_diag_2,'same');
        prewitt_x = conv2(A,Prewitt_G_x,'same');
        prewitt_y = conv2(A,Prewitt_G_y,'same');
        prewitt_diag_1 = conv2(A,Prewitt_diag_1,'same');
        prewitt_diag_2 = conv2(A,Prewitt_diag_2,'same');
        sobel(i-1,i1-1) = max([(abs(sobel_x(2,2))),(abs(sobel_y(2,2))),...
            abs(sobel_diag_1(2,2)),abs(sobel_diag_2(2,2))]);
        prewitt(i-1,i1-1) = max([(abs(prewitt_x(2,2))),...
            (abs(prewitt_y(2,2))),abs(prewitt_diag_1(2,2)),...
            abs(prewitt_diag_2(2,2))]);
        % dhmiourgia twn katwfliomenwn eikonwn
        if sobel(i-1,i1-1) >= oliko
            sobel_katwfli_oliko(i-1,i1-1) = 1;
        else sobel_katwfli_oliko(i-1,i1-1) = 0;
        end
        if prewitt(i-1,i1-1) >= oliko
            prewitt_katwfli_oliko(i-1,i1-1) = 1;
        else prewitt_katwfli_oliko(i-1,i1-1) = 0;
        end
        if sobel(i-1,i1-1) >= oliko1
            sobel_katwfli_oliko1(i-1,i1-1) = 1;
        else sobel_katwfli_oliko1(i-1,i1-1) = 0;
        end
        if prewitt(i-1,i1-1) >= oliko1
            prewitt_katwfli_oliko1(i-1,i1-1) = 1;
        else prewitt_katwfli_oliko1(i-1,i1-1) = 0;
        end
    end
end

%% parousiash twn eikonwn

figure
subplot(2,2,1),subimage(factory),title('arxikh')
subplot(2,2,2),subimage((sobel)),title('sobel')
subplot(2,2,3),subimage((sobel_katwfli_oliko)),title('sobel oliko 1')
subplot(2,2,4),subimage((sobel_katwfli_oliko1)),title('sobel oliko 2')
figure
subplot(2,2,1),subimage(factory),title('arxikh')
subplot(2,2,2),subimage((prewitt)),title('prewitt')
subplot(2,2,3),subimage((prewitt_katwfli_oliko)),title('prewitt oliko 1')
subplot(2,2,4),subimage((prewitt_katwfli_oliko1)),title('prewitt oliko 2')
