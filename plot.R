##################################################################
# plot.R
#
# 8/2/2017
##################################################################

rm(list=ls())

# demo(graphics); demo(persp)
plot(c(1,2,3),c(1,2,3))
Nile
mean(Nile)
sd(Nile)
hist(Nile)

##################################################################
# plot 함수
# plot(x, y, argument)
##################################################################

attach(mtcars)
plot(wt, mpg)
plot(wt, mpg, xlim=c(0,6),ylim=c(0,50),
     pch=21, cex=1.5, col="pink")
abline(lm(mpg ~ wt), col="darkblue",lty=1, lwd=2)              # 낮은 수준의 그래픽
title("Regression of MPG on Weight")

fit <- lm(mpg ~ wt, data=mtcars)
summary(fit)

fit$coef[1]

# detach(mtcars)

# plot() 함수의 옵션

# set.seed(100)
x <- rnorm(30)
y <- rnorm(30)
par(mfrow=c(2,2))
plot(x,y, type="b", main="cosie 그래프", sub = "type = b")
plot(x,y, type="o", las=1, bty="u", sub="type=o")
plot(x,y, type="h", bty="7", sub="type=h")
plot(x,y, type="s", bty="n", sub="type = s")

abline(a=1,b=1)    # 절편 = a, 기울기 = b인 직선 
abline(h=y)
abline(v=x)
abline(lm.obj)

# detach(mtcars)

data(cars)
attach(cars)
par(mfrow=c(2,2))
plot(speed, dist, pch=1); abline(v=15.4)
plot(speed, dist, pch=2); abline(h=43)
plot(speed, dist, pch=3); abline(-14, 3)
plot(speed, dist, pch=8); abline(v=15.4); abline(h=43)

# dot plot
dotchart(x, labels=)
# x는 숫자 vector, labels는 각 점의 레이블 
# group= option ; x를 그룹화할 factor 지정

dotchart(mtcars$mpg, labels= row.names(mtcars),
         cex=0.7,
         main="모델별 휘발유 마일리지",
         xlab="Gallon당 mile")

# barplot(height)   #height는 vector 또는 matrix
# Simple bar plot
counts <- table(mtcars$gear)
barplot(counts, main="Car Distribution", 
        xlab = "Number of Gears")

# Simple Horizontal Bar + label 추가
counts <- table(mtcars$gear)
barplot(counts, main="Car Distribution", horiz=TRUE, 
        names.arg = c("3 Gears", "4 Gears", "5 Gears"))

# Stacked Bar Plot
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Gear와 VS에 따른 자동차 분포",
        xlab="Gear의 수",col=c("darkblue","red"), 
        legend=rownames(counts))

# Grouped Bar plot
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Gears와 VS에 따른 자동차 분포",
        xlab="Gear의 수",col=c("darkblue","red"), 
        legend=rownames(counts), beside=TRUE)

# line()
x <- c(1:5)
y <- x
par(pch=22, col="red")
par(mfrow=c(2,4))
opts = c("p","l","o","b","c","s","S","h")
for(i in 1:length(opts)){
  heading = paste("type=", opts[i])
  plot(x,y, type="n", main=heading)
  lines(x,y, type=opts[i])
}

# Simple Pie Chart
slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie(slices, labels=lbls, main="Pie Chart of Countries")

# Pie chart with %
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct)
lbls <- past(lbls,"%", sep="")
pie(slices, labels=lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Countries")

# Box plot
# boxplot(x, data= ); data.frame

attach(mtcars)
boxplot(mpg ~ cyl, data=mtcars,
        main="자동차 마일리지 데이터",
        xlab="Cylinder 수", ylab="Miles Per Gallon")
detach(mtcars)

# 산점도(scatterplot): x, y는 numeric factor이며 두 개의 길이가 맞아야 함
plot(wt, mpg, main="Scatterplot의 예",
     xlab="자동자 무게", ylab="MPG",
     pch=19)










