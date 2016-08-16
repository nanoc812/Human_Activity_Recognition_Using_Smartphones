function corr_ = corrXY(X,Y)
%   Calculate the linear correlation coefficient between X and Y
rawsize = size(X);
corr_ = zeros(rawsize,1);
for i = 1: rawsize(1)
    corr_(i,1) = corr(X(i,:)',Y(i,:)');
end
end