function theX = preprocess( rawdata)
%   Tough work.
%   data preprocessing
raw = rawdata;
names = fieldnames(raw); % names, a Cell; names{i}, the ith element
tic
nfeatures = 561; ifeature = 1; ndata = 1; 
temp_str = ['ndata = length(raw.',names{1},'(:,1));'];
eval(temp_str) %% ndata = length(raw.names{1}(:,1));
theX = zeros(ndata,nfeatures);
numofFeatures = length(names);

%% %%%%%%%%%% g1
 nftr_g1 = 8; % number of features we get from g1;
for iftr = 1: numofFeatures
    temp_str =[['theX(:,ifeature+(iftr-1)*nftr_g1:ifeature+iftr*nftr_g1-1) =g1preprocess(raw.'...
        ,names{iftr}],');'] ;
    eval(temp_str);
end
savedata( theX, 'train_Xg1.txt');
ifeature = ifeature+ nftr_g1*numofFeatures;
%% %%%%%%%%%%% g2
nftr_g2 = 4;
for iftr = 1: 13
    temp_str =['theX(:,ifeature+(iftr-1)*nftr_g2:ifeature+iftr*nftr_g2-1) =g2preprocess(raw.'...
        ,names{iftr+20},');'] ;
    eval(temp_str);
end
savedata( theX, 'train_Xg2.txt');
ifeature = ifeature + (numofFeatures-21+1)*nftr_g2;
%% %%%%%%%%%%% g3 sma #####################################################
for iftr = 1:5
    temp_str = ['theX(:,ifeature+iftr-1) = (sum(abs(raw.',names{(iftr-1)*3+1},...
        '),2)+sum(raw.',names{(iftr-1)*3+2},',2)+sum(raw.'...
        ,names{(iftr-1)*3+3},',2))/length(raw.',names{(iftr-1)*3+1},'(1,:));'];
    eval(temp_str);
end
 ifeature = ifeature +5;
for iftr = 1:5
    temp_str = ['theX(:,ifeature+iftr-1) = sum(abs(raw.',names{iftr+15},...
        '),2)/length(raw.',names{iftr+15},'(1,:));'];
    eval(temp_str);
end
 ifeature = ifeature +5;
for iftr = 1:3 %7:9
    temp_str = ['theX(:,ifeature+iftr-1) = (sum(abs(raw.',names{(iftr+6)*3},...
        '),2)+sum(abs(raw.',names{(iftr+6)*3+1},'),2)+sum(abs(raw.',...
        names{(iftr+6)*3+2},'),2))/length(raw.',names{(iftr+6)*3+1},'(1,:));'];
    eval(temp_str);
end
 ifeature = ifeature +3;
for iftr = 1:4 %30:33
    temp_str = ['theX(:,ifeature+iftr-1) = sum(abs(raw.',names{iftr+29},...
        '),2)/length(raw.',names{iftr+29},'(1,:));'];
    eval(temp_str);
end
savedata( theX, 'train_Xg3.txt');
ifeature = ifeature +4;
%% %%%%%%%%%% g4 correlation #############################################
temp_str = ['theX(:,ifeature) = corrXY(raw.',names{1},',raw.',names{2},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+1) = corrXY(raw.',names{1},',raw.',names{3},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+2) = corrXY(raw.',names{3},',raw.',names{2},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+3) = corrXY(raw.',names{4},',raw.',names{5},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+4) = corrXY(raw.',names{6},',raw.',names{5},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+5) = corrXY(raw.',names{4},',raw.',names{6},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+6) = corrXY(raw.',names{7},',raw.',names{8},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+7) = corrXY(raw.',names{8},',raw.',names{9},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+8) = corrXY(raw.',names{7},',raw.',names{9},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+9) = corrXY(raw.',names{10},',raw.',names{12},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+10) = corrXY(raw.',names{10},',raw.',names{11},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+11) = corrXY(raw.',names{11},',raw.',names{12},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+12) = corrXY(raw.',names{13},',raw.',names{14},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+13) = corrXY(raw.',names{13},',raw.',names{15},');']; eval(temp_str);
temp_str = ['theX(:,ifeature+14) = corrXY(raw.',names{14},',raw.',names{15},');']; eval(temp_str);
savedata( theX, 'train_Xg4.txt');
ifeature = ifeature +15;
% % %%%%%%%%%%%% g5 arCoeff
 nftr_g5 = 4;
for iftr = 1:20
    temp_str = ['theX(:,ifeature+(iftr-1)*nftr_g5:ifeature+iftr*nftr_g5-1)=arCoeff(raw.'...
        ,names{iftr},');'];
    eval(temp_str);
end
savedata( theX, 'train_Xg5.txt');
ifeature = ifeature + nftr_g5*20;
% %%%%%%%%%% g6 bandsanergy
nftr_g6 = 42;
for iftr = 1:3
    temp_str = ['theX(:,ifeature+(iftr-1)*nftr_g6:ifeature+iftr*nftr_g6-1)=bandsenergy(raw.'...
        ,names{(iftr+6)*3},',raw.',names{(iftr+6)*3+1},',raw.',names{(iftr+6)*3+2},');'];
    eval(temp_str);
end 
savedata( theX, 'train_Xg6.txt');
ifeature = ifeature + nftr_g6*3;
% %%%%%%%%%% g7 angle acos(dot(a,b)/norm(a)/norm(b))/pi
b = meanVector(raw.names{4},raw.names{5},raw.names{6});
temp_str = ['b = meanVector(raw.',names{4},',raw.',names{5},',raw.',names{6},');']; eval(temp_str);
temp_str = ['a = meanVector(raw.',names{1},',raw.',names{2},',raw.',names{3},');']; eval(temp_str);
theX(:, ifeature) = acos(dot(a,b,2)./sqrt(sum(a.*a,2))./sqrt(sum(b.*b,2)))/pi; 
temp_str = ['a = meanVector(raw.',names{7},',raw.',names{8},',raw.',names{9},');']; eval(temp_str);
theX(:, ifeature+1) = acos(dot(a,b,2)./sqrt(sum(a.*a,2))./sqrt(sum(b.*b,2)))/pi; 
temp_str = ['a = meanVector(raw.',names{10},',raw.',names{11},',raw.',names{12},');']; eval(temp_str);
theX(:, ifeature+2) = acos(dot(a,b,2)./sqrt(sum(a.*a,2))./sqrt(sum(b.*b,2)))/pi; 
temp_str = ['a = meanVector(raw.',names{13},',raw.',names{14},',raw.',names{15},');']; eval(temp_str);
theX(:, ifeature+3) = acos(dot(a,b,2)./sqrt(sum(a.*a,2))./sqrt(sum(b.*b,2)))/pi; 
a = repmat([1,0,0],ndata,1); theX(:, ifeature+4) = acos(dot(a,b,2)./sqrt(sum(a.*a,2))./sqrt(sum(b.*b,2)))/pi; 
a = repmat([0,1,0],ndata,1); theX(:, ifeature+5) = acos(dot(a,b,2)./sqrt(sum(a.*a,2))./sqrt(sum(b.*b,2)))/pi; 
a = repmat([0,0,1],ndata,1); theX(:, ifeature+6) = acos(dot(a,b,2)./sqrt(sum(a.*a,2))./sqrt(sum(b.*b,2)))/pi; 
savedata( theX, 'train_Xg7.txt');
toc
end