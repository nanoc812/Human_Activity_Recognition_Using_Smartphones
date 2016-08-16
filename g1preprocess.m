function X_g1 = g1preprocess( rawdata )
%   Features extraction -- 33 features
feature = 8;
rawsize = size(rawdata);
X_g1 = zeros(rawsize(1),feature);
X_g1(:,1) = mean(rawdata,2);
X_g1(:,2) = std(rawdata,[],2);
X_g1(:,3) = max(rawdata,[],2);
X_g1(:,4) = min(rawdata,[],2);
X_g1(:,5) = median(rawdata,2);
X_g1(:,6) = iqr(rawdata,2);
X_g1(:,7) = sum(rawdata.*rawdata,2)/rawsize(2); % energy
for i = 1: rawsize(1) % entropy
    X_g1(i,8) = entropy(rawdata(i,:)); 
end
end

