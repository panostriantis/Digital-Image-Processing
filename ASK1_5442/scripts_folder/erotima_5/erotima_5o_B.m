%% 5o_erotima B meros - olikh e3iswsh istogrammatos

close all; clear all; clc

d_road_1 = ((imread('dark_road_1.jpg')));
d_road_2 = ((imread('dark_road_2.jpg')));
d_road_3 = ((imread('dark_road_3.jpg')));
% dhmiourgia enos hist matrix to opoio periexei tis times 0...255 sth prwth
% sthlh kai stis ypoloipes 8a periexei poses fores yparxei ka8e syxnothta
% apo 0...255 se ka8e mia apo tis treis eikones
hist_mat = zeros(256,4);
hist_mat(:,1) = (0:1:255)';
% metatroph ywn eikonwn se dianysmata
dr1_vec = d_road_1(:);
dr2_vec = d_road_2(:);
dr3_vec = d_road_3(:);
% gia tis 2 prwtes xrhsimopoieitai ena loop, gia na metrhsoume thn emfanish
% kaue syxnothtas, giati exoun to idio mege9os
for i = 1:1:length(dr1_vec)
    timh = double(dr1_vec(i,1));
    timh1 = double(dr2_vec(i,1));
    hist_mat(timh+1,2) = hist_mat(timh+1,2) + 1;
    hist_mat(timh1+1,3) = hist_mat(timh1+1,3) +1;
end
% h trith eikona
for i = 1:1:length(dr3_vec)
    timh = double(dr3_vec(i,1));
    hist_mat(timh+1,4) = hist_mat(timh+1,4)+1;
end
% edw ypologizontai oi pi8anothtes emfanishs
dr1 = hist_mat(:,2)./length(dr1_vec);
dr2 = hist_mat(:,3)./length(dr2_vec);
dr3 = hist_mat(:,4)./length(dr3_vec);
% edw ypologizetai to cumsum gia tis pi8anothtes emfanishs syxnothtas kai
% gia tis 3 eikones
for i = 1:256
    cs1(i,1) = sum(dr1(1:i));
    cs2(i,1) = sum(dr2(1:i));
    cs3(i,1) = sum(dr3(1:i));
end
% edw ypologizontai oi nees syxnothtes me vash to cumsum ths
% ka8e eikonas kai ginetai metatroph pali se uint8
for i = 1:length(dr1_vec)
    timh = double(dr1_vec(i,1));
    timh1 = double(dr2_vec(i,1));
    dr1_vec_n(i,1) = uint8(floor(255*cs1(timh+1,1)));
    dr2_vec_n(i,1) = uint8(floor(255*cs2(timh1+1,1)));
end
dr1_vec_n = reshape(dr1_vec_n,450,800);
dr2_vec_n = reshape(dr2_vec_n,450,800);
% to idio me th for panw (edw ginetai gia th trith eikona)
for i = 1:length(dr3_vec)
    timh = double(dr3_vec(i,1));
    dr3_vec_n(i,1) = uint8(floor(255*cs3(timh+1,1)));
end
dr3_vec_n = reshape(dr3_vec_n,480,640);
%% ta figure mas gia ta apotelesmata me emfanish twn istogrammatwn
figure
subplot(2,2,1),subimage(d_road_1),title('arxikh')
subplot(2,2,2),subimage(dr1_vec_n),title('meta thn e3iswsh')
subplot(2,2,3),imhist(d_road_1(:)),title('arxiko hist')
subplot(2,2,4),imhist(dr1_vec_n(:)),title('teliko hist')
figure
subplot(2,2,1),subimage(d_road_2),title('arxikh')
subplot(2,2,2),subimage(dr2_vec_n),title('meta thn e3iswsh')
subplot(2,2,3),imhist(d_road_2(:)),title('arxiko hist')
subplot(2,2,4),imhist(dr2_vec_n(:)),title('teliko hist')
figure
subplot(2,2,1),subimage(d_road_3),title('arxikh')
subplot(2,2,2),subimage(dr3_vec_n),title('meta thn e3iswsh')
subplot(2,2,3),imhist(d_road_3(:)),title('arxiko hist')
subplot(2,2,4),imhist(dr3_vec_n(:)),title('teliko hist')