function [ GA,BA ] = sepallGABA( rawdata,sign )
%   Extract Gravity Acceleration Signal and Body Acceleration Signal.
raw = rawdata;
rawsize = size(raw);
GA  = zeros(22); BA = zeros(64);

for idata = 1:rawsize(1)
    [GA(idata,:),BA(idata,:)] = sepGABA(raw(idata,:),sign);
end
end

