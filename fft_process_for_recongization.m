function [result]=fft_process_for_recongization(data)

minus_mean=[];

for i = 1:size(data,2)
    r=data(:,i)-mean(data(:,i));
    minus_mean=[minus_mean r];
end

result=[];
N=size(data,1);
for j=1:size(data,2)
    res = fftshift(ifft(fft(minus_mean(:,j),2*N-1).*conj(fft(minus_mean(:,size(data,2)),2*N-1))));
    result=[result res];
end

