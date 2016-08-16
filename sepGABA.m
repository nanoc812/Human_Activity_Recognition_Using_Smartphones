function [GA, BA] = sepGABA( rawData, sign)
%   Using Median Filter and Wavelet to extract high frequency and low
%   frequency signals, that are Gravity Acceleration Signal and Body
%   Acceleration Signal.
raw = rawData;
GA = zeros(size(raw));
BA = GA;
if sign ==0  %% Median filter and FFT
    raw_med = medfilt1(raw);
    raw_fft = fft(raw_med);
    temp = abs(ifft(raw_fft(raw_fft<=0.3)));
    GA(1:length(temp)) = temp;
    BA = abs(ifft(raw_fft((0.3<raw_fft<20))));
elseif sign ==1 %% wavelet
    lev = 5; [c,l] = wavedec(raw,lev,'sym8');
    xd = wden(c,l,'minimaxi','s','sln',lev,'sym8');
    
    [C,L] = wavedec(xd,5,'sym4'); Lev = 3; 
    GA = appcoef(C,L,'sym4',Lev);
    
    [c2,l2] = wavedec(xd,3,'db1');
    BA = detcoef(c2,l2,1);
%     subplot(4,1,2)
%     plot(xd), title('Minimaxi Denoising');
%     axis tight;
%     subplot(4,1,1)
%     plot(raw), title('raw data');
%     axis tight;
%     subplot(4,1,3)
%     plot(GA), title('GravityAcc signal');
%     axis tight;
%     subplot(4,1,4)
%     plot(BA), title('BodyAcc signal');
%     axis tight;
end
end

