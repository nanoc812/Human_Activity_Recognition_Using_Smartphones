function data = normalized(rawdata )
%   Normalizing
data = zeros(size(rawdata));
for i = 1: length(rawdata(1,:))
    if max(rawdata(:,i))-min(rawdata(:,i)) == 0
        data(:,i) = rawdata(:,i);
    else
        data(:,i) = (rawdata(:,i)-(max(rawdata(:,i))+min(rawdata(:,i)))/2)/...
            ((max(rawdata(:,i))-min(rawdata(:,i)))/2);
    end
end
end

