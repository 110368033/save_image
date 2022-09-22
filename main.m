close all;

data = data_merge('*.Wfm.csv',1,1); %filepath,channel,gesture
% 1:x_上  2:x_下  3:x_來回  4:y_1to2  5:y_2to1  6:y_來回  7:z_前  8:z_後  9:z_來回

all_dist=[];
all_ssim=[];
ges_list={'x_01.jpg';'x_02.jpg';'x_03.jpg';'x_04.jpg';'x_05.jpg';'x_06.jpg';'x_07.jpg';'x_08.jpg';'x_09.jpg';'x_10.jpg';'x_11.jpg';'x_12.jpg';'x_13.jpg';'x_14.jpg';'x_15.jpg';'x_16.jpg';'x_17.jpg';'x_18.jpg';'x_19.jpg';'x_20.jpg'};
for i=1:size(data,2)
    temp=data(:,i);
    data(:,i)=data(:,1);
    data(:,1)=temp;
    [dist_mid,ssim_mid]=data_preprocessing_for_saveimage(data,string(ges_list(i)));
    all_dist=[all_dist dist_mid];
    all_ssim=[all_ssim ssim_mid];
end

dist=mean(all_dist);
ssim=mean(all_ssim);

disp("DTW "+dist);
disp("SSIM "+ssim);