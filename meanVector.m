function vector = meanVector( X,Y,Z)
%   Calculate the mean vector~
raw = X;
rawsize = size(raw);
vector = zeros(rawsize(1),3);
for i = 1: rawsize(1)
    vector(i,:) = [mean(X(i,:)),mean(Y(i,:)),mean(Z(i,:))];
end
end

