%% 5o_erotima A meros - emfanish istogrammatwn twn eikonwn

close all; clear all; clc

d_road_1 = ((imread('dark_road_1.jpg')));
d_road_2 = ((imread('dark_road_2.jpg')));
d_road_3 = ((imread('dark_road_3.jpg')));
% dhmiourgia enos hist matrix to opoio periexei tis times 0...255 sth prwth
% sthlh kai stis ypoloipes 8a periexei poses fores yparxei ka8e syxnothta
% apo 0...255 se ka8e mia apo tis treis eikones
hist_mat = zeros(256,4);
hist_mat(:,1) = (0:1:255)';
% metatroph twn eikonwn se dianysmata
dr1_vec = d_road_1(:);
dr2_vec = d_road_2(:);
dr3_vec = d_road_3(:);
% metrhsh emfanishs syxnothtwn twn eikonwn
for i = 1:1:length(dr1_vec)
    timh = double(dr1_vec(i,1));
    timh1 = double(dr2_vec(i,1));
    hist_mat(timh+1,2) = hist_mat(timh+1,2) + 1;
    hist_mat(timh1+1,3) = hist_mat(timh1+1,3) +1;
end
% gia th trith eikona
for i = 1:1:length(dr3_vec)
    timh = double(dr3_vec(i,1));
    hist_mat(timh+1,4) = hist_mat(timh+1,4)+1;
end
% emfanish istogrammatwn me xrhsh bar
figure,bar(hist_mat(:,1),hist_mat(:,2)),title('dark road 1')
figure,bar(hist_mat(:,1),hist_mat(:,3)),title('dark road 2')
figure,bar(hist_mat(:,1),hist_mat(:,4)),title('dark road 3')