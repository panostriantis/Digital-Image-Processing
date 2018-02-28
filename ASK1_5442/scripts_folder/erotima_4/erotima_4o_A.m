%% 4o_erotima_A
% dhmioyrgoyntai oi eikones me padding antikatoptrismou twn akrwn tous
% me para8yra efarmoghs tou median 3x3 kai 5x5

close all; clear all; clc

% building
building = im2double(imread('building.jpg'));
building_3x3 = padding_mirror(building,1);
building_5x5 = padding_mirror(building,2);

% train
train = im2double(imread('train.jpg'));
train_3x3 = padding_mirror(train,1);
train_5x5 = padding_mirror(train,2);

% arxikopoihsh twn mege8wn twn (padded) eikonwn
[x_b3,y_b3] = size(building_3x3);
[x_t3,y_t3] = size(train_3x3);

[x_b5,y_b5] = size(building_5x5);
[x_t5,y_t5] = size(train_5x5);

% pragmatopoihsh tou kwdika gia to median

% building me window 3x3
for i = 2:x_b3-1
    fprintf('building - eimaste sth grammh: %d\n',i);
    for i1 = 2:y_b3-1
        A3 = building_3x3(i-1:i+1,i1-1:i1+1);
        filt_A3 = reshape(sort(A3(:)),3,3);
        building_3x3_n(i-1,i1-1) = filt_A3(2,2);
    end
end
building_n3 = building_3x3_n;

% train me window 3x3
for i = 2:x_t3-1
    fprintf('train - eimaste sth grammh: %d\n',i);
    for i1 = 2:y_t3-1
        B3 = train_3x3(i-1:i+1,i1-1:i1+1);
        filt_B3 = reshape(sort(B3(:)),3,3);
        train_3x3_n(i-1,i1-1) = filt_B3(2,2);
    end
end
train_n3 = train_3x3_n;

% building me window 5x5
for i = 3:x_b5-2
    fprintf('building - eimaste sth grammh: %d\n',i);
    for i1 = 3:y_b5-2
        A5 = building_5x5(i-2:i+2,i1-2:i1+2);
        filt_A5 = reshape(sort(A5(:)),5,5);
        building_5x5_n(i-2,i1-2) = filt_A5(3,3);
    end
end
building_n5 = building_5x5_n;

% train me window 5x5
for i = 3:x_t5-2
    fprintf('train - eimaste sth grammh: %d\n',i);
    for i1 = 3:y_t5-2
        B5 = train_5x5(i-2:i+2,i1-2:i1+2);
        filt_B5 = reshape(sort(B5(:)),5,5);
        train_5x5_n(i-2,i1-2) = filt_B5(3,3);
    end
end
train_n5 = train_5x5_n;

figure,subplot(1,3,1),imshow(building),title('arxikh')
subplot(1,3,2),imshow(building_n3),title('3x3')
subplot(1,3,3),imshow(building_n5),title('5x5')
%figure, imshow(building_n5)
figure,subplot(1,3,1),imshow(train),title('arxikh')
subplot(1,3,2),imshow(train_n3),title('3x3')
subplot(1,3,3),imshow(train_n5),title('5x5')
%figure, imshow(train_n5)
