########################################################################
#
# script_5.R
#
# 8/4/2017
#
# data munging
#
########################################################################

rm(list=ls())


# CSV 파일을 읽어들이기
# dau: daily active users
dau <- read.csv("section3-dau.csv", header = T, stringsAsFactors = F)
str(dau)
head(dau)

# dpu: daily paid users (과금유저)
dpu <- read.csv("section3-dpu.csv", header = T, stringsAsFactors = F)
str(dpu)
head(dpu)

# install: 신규 가입자
install <- read.csv("section3-install.csv", header = T, stringsAsFactors= F)
str(install)
head(install)

# DAU 데이터에 Install 데이터를 결합시키기
dau.install <- merge(dau, install, by = c("user_id", "app_name"))
str(dau.install)
head(dau.install)

# 위 데이터에 다시 DPU 데이터를 결합시키기
dau.install.payment <- merge(dau.install, dpu, by = c("log_date",
                                                      "app_name", 
                                                      "user_id"), 
                             all.x = T)

# all.x: logical; if TRUE, then extra rows will be added to the output,
# one for each row in x that has no matching row in y. 
# These rows will have NAs in those columns that are usually filled with
# values from y. The default is FALSE, so that only rows with data from 
# both x and y are included in the output.

head(dau.install.payment)
str(dau.install.payment)
head(na.omit(dau.install.payment))

# 비과금 유저의 과금액에 0을 넣기
dau.install.payment$payment[is.na(dau.install.payment$payment)] <- 0
head(dau.install.payment)

# 월차로 집계하기

# 월 항목 추가
dau.install.payment$log_month <-substr(dau.install.payment$log_date, 1, 7)
dau.install.payment$install_month <- substr(dau.install.payment$install_date, 1, 7)

# install.packages("plyr")
library(plyr)
mau.payment <- ddply(dau.install.payment,
                     .(log_month, user_id, install_month), # 그룹화
                     summarize, # 집계 명령
                     payment = sum(payment) # payment 합계
)

str(mau.payment)
head(mau.payment)

# 신규 유저인지 기존 유저인지 구분하는 항목을 추가
# 신규 유저와 기존 유저 식별
mau.payment$user.type <- ifelse(mau.payment$install_month == mau.payment$log_month,
                                "install", "existing")
str(mau.payment)
head(mau.payment)

mau.payment$user.type[26000]
mau.payment.summary <- ddply(mau.payment,
                             .(log_month, user.type), # 그룹화
                             summarize, # 집계 명령어
                             total.payment = sum(payment) # payment 합계
)
str(mau.payment.summary)
head(mau.payment) 
head(mau.payment.summary)

# 그래프로 데이터를 시각화하기 （geom_bar()　->　geom_bar(stat="identity")로 수정 2014/08/22）
library(ggplot2)
library(scales)
ggplot(mau.payment.summary, aes(x = log_month, y = total.payment,
                                fill = user.type)) + 
  geom_bar(stat="identity") + scale_y_continuous(label = comma)

ggplot(mau.payment[mau.payment$payment > 0 & mau.payment$user.type == "install", ], 
       aes(x = payment, fill = log_month)) + 
  geom_histogram(position = "dodge", binwidth = 20000)

##  4장 소스코드
# CSV 파일을 읽어들이기
dau <- read.csv("section4-dau.csv", header = T, stringsAsFactors = F)
str(dau)
head(dau)

user.info <- read.csv("section4-user_info.csv", header = T, stringsAsFactors = F)
str(user.info)
head(user.info)

# DAU에 user.info를 결합시키기
dau.user.info <- merge(dau, user.info, by = c("user_id", "app_name"))
str(dau.user.info)
head(dau.user.info)

# 월 항목을 추가
dau.user.info$log_month <- substr(dau.user.info$log_date, 1, 7)
str(dau.user.info)

# 세그먼트 분석（성별로 집계）
table(dau.user.info[, c("log_month", "gender")])

# 세그먼트 분석(연령대별로 집계）
table(dau.user.info[, c("log_month", "generation")])

# 세그먼트 분석（성별과 연령대를 조합해 집계）
library(reshape2)
dcast(dau.user.info, 
      log_month ~ gender + generation, 
      value.var = "user_id",
      length)

# 세그먼트 분석（단말기별로 집계）
table(dau.user.info[,c("log_month","device_type")])

# 세그먼트 분석 결과를 시각화하기
# 날짜별로 단말기별 유저수를 산출하기
dau.user.info.device.summary <- ddply(dau.user.info, .(log_date, device_type), summarize, dau = length(user_id))

# 날짜별 데이터 형식으로 변환하기
dau.user.info.device.summary$log_date <- as.Date(dau.user.info.device.summary$log_date)

# 시계열의 트렌드 그래프 그리기
library(ggplot2)
library(scales)
limits <- c(0, max(dau.user.info.device.summary$dau))
ggplot(dau.user.info.device.summary, 
       aes(x=log_date, 
           y=dau, 
           col=device_type, 
           lty=device_type, 
           shape=device_type)) +
  geom_line(lwd=1) +
  geom_point(size=4) +
  scale_y_continuous(label=comma, limits=limits)


