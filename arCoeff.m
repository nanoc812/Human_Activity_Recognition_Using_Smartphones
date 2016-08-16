function X_g5 = arCoeff( rawdata )
%   Calculate the Autorregresion coefficients
feature = 4;
rawsize = size(rawdata);
X_g5 = zeros(rawsize(1),feature);
for i = 1: rawsize(1)
    % Estimate parameters of AR model for scalar time series
    m = ar(rawdata(i,:),4);
    X_g5(i,:) =m.a(2:5);
end
end

