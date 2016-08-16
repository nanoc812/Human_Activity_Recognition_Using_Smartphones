setwd("C:/Users/Nano_Wang/Documents/Rfiles")

X_train <- as.matrix(read.table("X_train.txt"))
Y_train <- as.matrix(read.table("Y_train.txt"))
X_test <- as.matrix(read.table("X_test.txt"))
Y_test <- as.matrix(read.table("Y_test.txt"))
X_tr_FFT <- as.matrix(read.table("no_theX_new.txt"))
X_te_FFT <- as.matrix(read.table("no_theX_tnew.txt"))
X_tr_let <- as.matrix(read.table("no_theX_tr_let.txt"))
X_tr_let2 <- as.matrix(read.table("no_theX_tr_let2.txt"))
X_te_let <- as.matrix(read.table("no_theX_te_let2.txt"))

library("e1071", lib.loc="~/R/win-library/3.2")
data_train <- data.frame(x=X_train, y=as.factor(Y_train))
data_test <- data.frame(x=X_test, y=as.factor(Y_test))

data_tr_FFT <- data.frame(x=X_tr_FFT, y=as.factor(Y_train))
data_te_FFT <- data.frame(x=X_te_FFT, y=as.factor(Y_test))
data_tr_let <- data.frame(x=X_tr_let, y=as.factor(Y_train))
data_tr_let2 <- data.frame(x=X_tr_let2, y=as.factor(Y_train))
data_te_let <- data.frame(x=X_te_let, y=as.factor(Y_test))

##############################################################
# butterworth
set.seed(1)
fit_li=svm(y~., data=data_train, kernel="linear",  gamma=0.5, cost=0.1)
ypred=predict(fit_li,data_test)
pred_ <- tableSVM(ypred,data_test)

tune_li=tune(svm, y~., data=data_train, kernel="linear", 
              ranges=list(cost=c(0.1,0.4,0.8),gamma=c(0.1,0.5)))
ypred_li_tu <- predict(tune_li$best.model,data_test)
pred_li_tu <- tableSVM(ypred_li_tu,data_test)
#############################################################
# FFT
set.seed(1)
fit_li_FFT=svm(y~., data=data_tr_FFT, kernel="linear",  gamma=5, cost=0.1)
ypred_FFT =predict(fit_li_FFT,data_te_FFT)
pred_FFT <- tableSVM(ypred_FFT,data_te_FFT)

set.seed(1)
fit_ra <- svm(y~., data=data_train, kernel="radial",  gamma=1, cost=10)
ypred_ra=predict(fit_ra,data_test)
pred_ra <- tableSVM(ypred_ra,data_test)
############################################################
# wavelet
set.seed(1)
fit_li_let=svm(y~., data=data_tr_let, kernel="linear",  gamma=5, cost=0.1)
ypred_let =predict(fit_li_let,data_te_let)
pred_let <- tableSVM(ypred_let,data_te_let)

tune_li_let2=tune(svm, y~., data=data_tr_let, kernel="linear", 
             ranges=list(cost=c(0.1,0.5,1,2,3),gamma=c(0.1,0.5,1,10)))
ypred_li_let2 <- predict(tune_li_let2$best.model,data_te_let)
pred_li_let2 <- tableSVM(ypred_li_let2,data_te_let)
################# function ################################
tableSVM <-function(ypred,data_test){
  ndata <- length(as.matrix(ypred)); nfail =0
  tt <- table(predict=ypred, truth=data_test$y)
  tt <- cbind(tt,c(0)); tt <- rbind(tt,c(0));
  len <- length(tt[,1])
  for(i in 1:(len-1)){ 
    tt[len,i] = max(tt[1:(len-1),i])/sum(tt[1:(len-1),i]);
    tt[i,len] = max(tt[i,1:(len-1)])/sum(tt[i,1:(len-1)]);
    nfail = nfail + sum(tt[i,1:(len-1)])-max(tt[i,1:(len-1)])
  }
  tt[len,len] = 1- nfail/ndata;
  tt <- t(tt)
}
