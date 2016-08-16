function todo = dataprepare(file,sign)
%   Data preparing
% sign ==0, FFT and median
% sign ==1, wavelet
% file ==0, train set
% file ==1, test set
if file ==0
    totalAccX = load('total_acc_x_train.txt');
    totalAccY = load('total_acc_y_train.txt');
    totalAccZ = load('total_acc_z_train.txt');
    bodyGyroX = load('body_gyro_x_train.txt');
    bodyGyroY = load('body_gyro_y_train.txt');
    bodyGyroZ = load('body_gyro_z_train.txt');
elseif file ==1
    totalAccX = load('total_acc_x_test.txt');
    totalAccY = load('total_acc_y_test.txt');
    totalAccZ = load('total_acc_z_test.txt');
    bodyGyroX = load('body_gyro_x_test.txt');
    bodyGyroY = load('body_gyro_y_test.txt');
    bodyGyroZ = load('body_gyro_z_test.txt');
end
%% remmove the noise
tbodyGyroX = medfilt1(bodyGyroX,3,[],2); %
tbodyGyroY = medfilt1(bodyGyroY,3,[],2);
tbodyGyroZ = medfilt1(bodyGyroZ,3,[],2);
[tgravityAccX,tbodyAccX] = sepallGABA(totalAccX,sign); %%
[tgravityAccY,tbodyAccY] = sepallGABA(totalAccY,sign);
[tgravityAccZ,tbodyAccZ] = sepallGABA(totalAccZ,sign);
%% data preparetion
tbodyAccJerkX = jerk(tbodyAccX);%
tbodyAccJerkY = jerk(tbodyAccY);
tbodyAccJerkZ = jerk(tbodyAccZ);
tbodyGyroJerkX = jerk(tbodyGyroX);%
tbodyGyroJerkY = jerk(tbodyGyroY);
tbodyGyroJerkZ = jerk(tbodyGyroZ);

fbodyAccX = abs(fft(tbodyAccX,[],2));%
fbodyAccY = abs(fft(tbodyAccY,[],2));
fbodyAccZ = abs(fft(tbodyAccZ,[],2));
fbodyAccJerkX = abs(fft(tbodyAccJerkX,[],2));%
fbodyAccJerkY = abs(fft(tbodyAccJerkY,[],2));
fbodyAccJerkZ = abs(fft(tbodyAccJerkZ,[],2));
fbodyGyroX = abs(fft(tbodyGyroX,[],2));%
fbodyGyroY = abs(fft(tbodyGyroY,[],2));
fbodyGyroZ = abs(fft(tbodyGyroZ,[],2));

%%%% magnitude 
tbodyAccMag = sqrt(tbodyAccX.*tbodyAccX+ tbodyAccY.*tbodyAccY +tbodyAccZ.*tbodyAccZ);
tgravityAccMag = sqrt(tgravityAccX.*tgravityAccX +tgravityAccY.*tgravityAccY ...
    +tgravityAccZ.*tgravityAccZ);
tbodyGyroMag = sqrt(tbodyGyroX.*tbodyGyroX+tbodyGyroY.*tbodyGyroY+tbodyGyroZ.*tbodyGyroZ);
tbodyAccJerkMag = sqrt(tbodyAccJerkX.*tbodyAccJerkX+tbodyAccJerkY.*tbodyAccJerkY...
    +tbodyAccJerkZ.*tbodyAccJerkZ);
tbodyGyroJerkMag = sqrt(tbodyGyroJerkX.*tbodyGyroJerkX+tbodyGyroJerkY.*tbodyGyroJerkY...
    +tbodyGyroJerkZ.*tbodyGyroJerkZ);
fbodyAccMag = abs(fft(tbodyAccMag,[],2));
fbodyGyroMag = abs(fft(tbodyGyroMag,[],2));
fbodyAccJerkMag = abs(fft(tbodyAccJerkMag,[],2));
fbodyGyroJerkMag = abs(fft(tbodyGyroJerkMag,[],2));
%% save them in a structure
todo = struct('tbodyAccX',tbodyAccX...
    ,'tbodyAccY',tbodyAccY...
    ,'tbodyAccZ',tbodyAccZ...
    ,'tgravityAccX',tgravityAccX...
    ,'tgravityAccY',tgravityAccY...
    ,'tgravityAccZ',tgravityAccZ...
    ,'tbodyGyroX',tbodyGyroX...
    ,'tbodyGyroY',tbodyGyroY...
    ,'tbodyGyroZ',tbodyGyroZ...
    ,'tbodyAccJerkX',tbodyAccJerkX...
    ,'tbodyAccJerkY',tbodyAccJerkY...
    ,'tbodyAccJerkZ',tbodyAccJerkZ...
    ,'tbodyGyroJerkX',tbodyGyroJerkX...
    ,'tbodyGyroJerY',tbodyGyroJerkY...
    ,'tbodyGyroJerkZ',tbodyGyroJerkZ...
    ,'tbodyAccMag',tbodyAccMag...
    ,'tgravityAccMag',tgravityAccMag...
    ,'tbodyGyroMag',tbodyGyroMag...
    ,'tbodyAccJerkMag',tbodyAccJerkMag...
    ,'tbodyGyroJerkMag',tbodyGyroJerkMag...
    ,'fbodyAccX',fbodyAccX...
    ,'fbodyAccY',fbodyAccY...
    ,'fbodyAccZ',fbodyAccZ...
    ,'fbodyAccJerkX',fbodyAccJerkX...
    ,'fbodyAccJerkY',fbodyAccJerkY...
    ,'fbodyAccJerkZ',fbodyAccJerkZ...
    ,'fbodyGyroX',fbodyGyroX...
    ,'fbodyGyroY',fbodyGyroY...
    ,'fbodyGyroZ',fbodyGyroZ...
    ,'fbodyAccMag',fbodyAccMag...
    ,'fbodyGyroMag',fbodyGyroMag...
    ,'fbodyAccJerkMag',fbodyAccJerkMag...
    ,'fbodyGyroJerkMag',fbodyGyroJerkMag);
end