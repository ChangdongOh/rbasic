#####################################################################
# rscript_4.R
#
# 8/3/2017
#
#####################################################################

rm(list=ls())

#####################################################################
# 기술통계 
#####################################################################
mydata <- mtcars
apply(mydata,2,mean)
sapply(mydata, mean)
summary(mydata)

x <- rnorm(100)
hist(x)

# 밀도 plot
# 핵 밀도(Kernel Density) Plots
# 단 x는 수치(numeric) 벡터; 
# 비모수적 밀도추정(경제학, 경영학에서 많이 사용)
plot(density(x)) 

# Kernel Density Plot
d <- density(mydata$mpg)
plot(d) # plot the results

# filled Density plot
d <- density(mtcars$mpg)
plot(d, 
     main="Kernel Density of Miles of Per Gallon")
polygon(d, col="red", border="blue")

# Kernel Density를 이용한 집단 비교
# - sm package의 sm.density.compare(x, factor)
#   - x는 숫자 vector, factor는 grouping 변수 
#   - superimpose the kernel density plots of two or more groups

# MPG 분포를 비교(cars with 4,6, or 8 cylinders)
library(sm)
attach(mtcars)

unique(mtcars$cyl)

# value label 생성 (factor로 변환, 원래 cyl=4,6,8의 수치형 변수)
cyl.f <- factor(cyl, levels=c(4,6,8),
                labels = c("4 cylinders", "6 cylinders", "8 cylinders"))

# 밀도곡선의 plotting
sm.density.compare(mpg, cyl.f, 
                   xlab="Miles Per Gallon",
                   size=3)
title(main="MPG Distribution by Car Cylinder")

# 마우스를 클릭하는 곳에 legend를 추가
colfill <- c(2:(length(levels(cyl.f))+1))  # vector of color
legend(locator(1), levels(cyl.f), 
       fill=colfill)

legend("topright", levels(cyl.f), fill=colfill)

cor(mydata$mpg, mydata$cyl)

#####################################################################
# 선형회귀 복습
# 내장된 faithful data 활용
#####################################################################

fit.1 <- lm(eruptions ~ waiting,
            data=faithful)
summary(fit.1)

coeffs <- coefficients(fit.1)
coeffs

# fit equation duration: 80 min
waiting <- 80
duration <- coeffs[1] + coeffs[2]*waiting
duration

# other solution
newdata <- data.frame(waiting=80)
predict(fit.1, newdata)

# checking r2
summary(fit.1)$r.squared

# 신뢰구간 (95%): eps ~ iid N(0, constant variance) 가정
# x값이 주어졌을 때, y.bar에 대한 추정
predict(fit.1, newdata,
        interval="confidence")

# 예측구간(95% prediction interval)
# x값이 주어졌을 때, 종속변수 y에 대한 구간 추정
predict(fit.1, newdata,
        interval="predict")

# 잔차(residual) 그림: residual = y - y.hat
fit.resid <- resid(fit.1)
plot(faithful$waiting, fit.resid, 
     ylab="Residuals", xlab="Waiting Time",
     main="Old Faithful Eruptions")
abline(0,0)

# using car package
library(car)
qqPlot(fit.1)

# using water data
# install.packages("alr3")
library(alr3)

data(water)
str(water)

social.water <- water[,-1]
head(social.water)

# correlation plot
# install.packages("corrplot")
library(corrplot)

water.cor <- cor(social.water)
water.cor

corrplot(water.cor, method="ellipse")

# 
fit.2 <- lm(BSAAM ~ APSLAKE + OPSLAKE, data=social.water)
summary(fit.2)

par(mfrow=c(2,2))
plot(fit.2)
par(mfrow=c(1,1))

# plot
plot(fit.2$fitted.values, social.water$BSAAM, 
     xlab="predicted", ylab="actual", main="Predicted vs. Actual")


social.water["Actual"] <- water$BSAAM
social.water["Forecast"] <- NA

social.water$Forecast <- predict(fit.2)

# by using ggplot2 package
# install.pacakges("ggplot2")
library(ggplot2)

q <- ggplot(social.water, aes(x=Forecast, y=Actual)) +
  geom_point() +
  geom_smooth(method=lm) +
  labs(title="Forecast vs. Actuals")
q

#####################################################################
# Logistic Regression 
# Generalized Linear Regression
#
#####################################################################

# mtcars 데이터 활용
# mtcars에서 120마력의 엔진과 2800 lbs.의 무게를 가진 경우
# 수동 변속기로 판명될(fitted)  확률은?

mtcars$am

fit.glm <- glm(am ~ hp + wt, data=mtcars,
               family=binomial(link="logit"))
newdata.glm <- data.frame(hp=120, wt=3.8)
predict(fit.glm, newdata.glm,
        type="response")
summary(fit.glm)

# using effects package
# install.packages("effects")
library(effects)
eff.fit.glm <- allEffects(fit.glm, 
                          ask=FALSE, 
                          rescale.axis=TRUE)

plot(eff.fit.glm,band.colors="blue", 
     band.transparency=.15,
     ylab="Prob(Manual Trans)", main="")

# 한글로 저장을 원할 때
pdf("effect_1.pdf",width=14,height=12,family="Korea1deb")
plot(eff.fit.glm,band.colors="blue", band.transparency=.15,
     ylab="수동변속기일 확률", main="")
dev.off()


# 연습
rm(list=ls())                       # 이전에 R 작업공간에 있었던 것 삭제

# 작업 디렉토리 설정
# setwd("~/Teaching/R_basic/2017_7/lec_4")

uspres <- read.csv("uspres.csv", header=TRUE)

# Basic scatterplot matrix
pairs(~inc_vsh + gallup_rating + income_change + big_3rd,
      data = uspres,
      main = "Simple Scatterplot Matrix")

# simple regression
fit.1 <- lm(inc_vsh ~ gallup_rating, data = uspres)
summary(fit.1)

fit.2 <- lm(inc_vsh ~ income_change,
            data = uspres)
summary(fit.2)

fit.3 <- lm(inc_vsh ~ big_3rd, data = uspres)
summary(fit.3)

# multiple regression
fit.4 <- lm(inc_vsh ~ gallup_rating + income_change +
              big_3rd, data = uspres)
summary(fit.4)  

# adding the fitted line
plot(uspres$gallup_rating, uspres$inc_vsh)
abline(fit.1, col="green2", lwd =2)

#################################################################
library(foreign)                    # foreign이라는 패키지 사용                    

dat <- read.dta("Tax_Data.dta")    # 데이터를 작업 디렉토리로부터 불러오기, 불러온 후 dat라는 이름으로 저장한 것

str(dat)                           # dat이라는 데이터의 구조(structure)를 확인

# 상관관계
cor(dat$totaltax, dat$right, use="complete.obs")

# 회귀식
fit.1 <- lm(totaltax ~ right, data=dat)
summary(fit.1)

# plot
plot(dat$right, dat$totaltax)
abline(fit.1, col="green", lwd=2, lty=2)

summary(dat)         # 불러들인 데이터 요약

# 일반 그림
res <- lm(totaltax ~ right, data=dat)     # lm(종속변수 ~ 독립변수, data=사용할 데이터)를 사용한 후 res라는 이름으로 저장
summary(res)                              # 회귀분석 결과 보여줌 

plot(dat$totaltax ~ dat$right, xlab="우파비율(%)", ylab="조세/GDP(%)",
     main="의회 내 우파비율과 조세 수준",pch=20,col="gray") 
abline(a=res$coef[1],b=res$coef[2],col="red",lwd=2)

# identifying points
identify(dat$totaltax ~ dat$right, labels=dat$name)

# 복지레짐별 구분 데이터 입력: social democratic, conservative, liberal
welfare <- c("Liberal","Conservative","Conservative","Liberal","Social Democratic","Social Democratic",
             "Conservative","Conservative","Social Democratic","Liberal","Conservative","Conservative",
             "Liberal","Social Democratic","Social Democratic","Conservative","Liberal","Liberal")

new.dat <- data.frame(dat,welfare)

#수채화 그림 그리기, 작업 디렉토리 안에  vwReg.R이라는 파일이 있어야 함.
source("vwReg.R")                      

vwReg(totaltax ~ right, data=dat)

# ggplot으로 그리기
g <- ggplot(new.dat, 
            aes(x=right,y=totaltax,colour=welfare,label=name)) +
  scale_colour_hue(l=65) +
  geom_point(shape=1,size=4,show_guide=TRUE) +
  geom_smooth(method=lm,size=1,se=FALSE, fullrange=TRUE) +
  geom_text(aes(label=name),hjust=0.4,vjust=1.2)

g









