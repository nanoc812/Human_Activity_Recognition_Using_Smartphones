function X_g2 = g2preprocess( rawdata )
%Calculate the maximum, mean value, skewness and kurtosis of each data
feature = 4;
rawsize = size(rawdata);
X_g2 = zeros(rawsize(1),feature);
[~,X_g2(:,1)] = max(rawdata,[],2); % maxInds %%%%%%%%%%%%%
X_g2(:,2) = mean(rawdata,2); % meanFreq
X_g2(:,3) = skewness(rawdata,[],2);
X_g2(:,4) = kurtosis(rawdata,[],2);
end

