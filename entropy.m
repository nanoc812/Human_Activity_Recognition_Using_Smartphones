function ent = entropy( rawdata )
%   Calculate signal entropy
N = 64;
pdf  = zeros(1,N);
ent = 0; temp = 0;
raw = sort(rawdata);
len = length(raw);
delta = (raw(len)-raw(1))/N;
for i = 1:N
    if(i<N)
        pdf(i) = 1-length(raw(raw>(raw(1)+i*delta)))/len;
    elseif i == N
        pdf(i) = 1;
    end
end
for j = 1:N-1
    temp = pdf(j+1)-pdf(j);
    if(temp == 0)
        ent = ent;
    else
        ent = ent - temp*log2(temp);
    end
end
end

