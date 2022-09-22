function [dist_mid,ssim_mid,dist_all,ssim_all]=data_preprocessin_for_saveimage(data)

data=data*1000;

% temp=data(:,10);
% data(:,10)=data(:,1);
% data(:,1)=temp;

data_normalize=[];
data_smooth=[];
% figure;
% hold on 
for i=1:size(data,2)
%     plot(data(:,i));title('raw data');
    data_nor=normalize(data(:,i), 'range', [-1 1]);
    data_normalize=[data_normalize,data_nor];
end
% hold off


% figure;
% hold on 
for i=1:size(data,2)
    data_smo=smooth(data_normalize(:,i),10,'moving');
    data_smooth=[data_smooth,data_smo];
%     plot(data_smo);title('normalize & smooth');
end
% hold off

% temp=data_smooth(:,10);
% data_smooth(:,10)=data_smooth(:,1);
% data_smooth(:,1)=temp;
% 
% figure;plot(data_smooth(:,1));ylim([-1 1]);
% fig=plot(data_smooth(:,1));
% saveas(gcf,ges);

fft_result1=fft_process_for_recongization(data_smooth); 
fs=100;
N=size(data_smooth,1);
t = -(N-1)/fs:1/fs:(N-1)/fs;
data2=[];
for i=1:size(fft_result1,2)
    [~,index]=max(fft_result1(:,i));
    diff=length(t)-index;
    reg=circshift(data_smooth(:,i),-diff);
    data2=[data2 reg];
end

% figure;
% hold on 
% for i=1:size(fft_result1,2)
%     plot(t,fft_result1(:,i));title('1st auto-correlation');
% end
% hold off

% figure;
% hold on 
% for i=1:size(data2,2)
%     plot(data2(:,i));title('1st align Amplitude');
% end
% hold off

fft_result2=fft_process_for_recongization(data2);
N=size(data2,1);
t = -(N-1)/fs:1/fs:(N-1)/fs;
data3=[];
for i=1:size(fft_result2,2)
    [~,index2]=max(fft_result2(:,i));
    diff2=length(t)-index2;
    reg2=circshift(data2(:,i),-diff2);
    data3=[data3 reg2];
end

% figure;
% hold on 
% for i=1:size(fft_result2,2)
%     plot(t,fft_result2(:,i));title('2nd auto-correlation');
% end
% hold off

% figure;
% hold on 
% for i=1:size(data3,2)
%     plot(data3(:,i));title('2st align Amplitude');
% end
% hold off

fft_result3=fft_process_for_recongization(data3);
N=size(data3,1);
t = -(N-1)/fs:1/fs:(N-1)/fs;

% figure;
% hold on 
% for i=1:size(fft_result3,2)
%     plot(t,fft_result3(:,i));title('3rd auto-correlation');
% end
% hold off

ssim_all=[];
dist_all=[];

for q=1:size(data3,2)
    Fs=1;
    ssim_=abs(ssim(data3(:,q),data3(:,size(data3,2))));
    ssim_all=[ssim_all ssim_];
    [dist,ix,iy] = dtw(data3(:,q),data3(:,size(data3,2)));
    dist_all=[dist_all dist];
    a1w_=data3(:,q);
    a2w_=data3(:,size(data3,2));
    a1w = a1w_(ix);
    a2w = a2w_(iy);
    t = (0:numel(ix)-1)/Fs;
    duration = t(end);
   
%     figure;
%     subplot(2,1,1);
%     plot([a1w_(ix);a2w_(iy)]','.-');
%     title(['Distance: ' num2str(dist)]);
%     subplot(2,1,2);
%     plot(ix,iy,'o-',[ix(1) ix(end)],[iy(1) iy(end)]);
%     
%     figure;
%     subplot(2,1,1);
%     plot(t,a1w);
%     title('a_1, Warped');
%     subplot(2,1,2);
%     plot(t,a2w);
%     title('a_2, Warped');
%     xlabel('Time (seconds)');

end

dist_mid=mean(dist_all);
ssim_mid=mean(ssim_all);
