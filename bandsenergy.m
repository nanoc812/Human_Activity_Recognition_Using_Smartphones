function energy_ = bandsenergy( X,Y,Z)
% sign: the mark to figure out the Gyro and bodyAcc
%Fs = 50;
rawsize = size(X);
if length(X(1,:)) > 22 %sign ==0
    fr =[1,8;9,16;17,24;25,32;33,40;41,48;49,56;57,63;1,16;17,32;33,48;49,63;1,24;25,48];
else % sign ==1 
    fr =[1,4;5,8;9,12;13,16;17,20;21,22;1,8;9,16;17,22];
end
feature = length(fr(:,1))*3;
energy_ = zeros(rawsize,feature);
temp = zeros(1,feature/3);
for i = 1: rawsize(1)
    x =X(i,:);y=Y(i,:);z=Z(i,:);
    for j = 1:feature/3
        temp(j)=sum(x(fr(j,1):fr(j,2)).^2,2)+sum(y(fr(j,1):fr(j,2)).^2,2)+sum(z(fr(j,1):fr(j,2)).^2,2);
    end
    energy_(i,:) = [temp,temp,temp];
end
end

