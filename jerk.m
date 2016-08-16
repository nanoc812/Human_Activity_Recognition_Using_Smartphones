function jerkdata = jerk( rawdata )
%   Calculate Accelaration Jerk: da/dt and dw/dt
raw = rawdata;
rawsize = size(raw);
jerkdata  = zeros(rawsize(1),rawsize(2)-1);

deltaT = 1/50; % 50Hz
for idata = 1: rawsize(1)
    for iacc = 1: rawsize(2)-1
        jerkdata(idata,iacc) = (raw(idata,iacc+1)-raw(idata,iacc))/deltaT;
    end
end
end

