#################################################################################
#
# script_2.R
#
# 8/1/2017 
#
# by 구본상
#
#################################################################################

# 작업 디렉토리 확인
getwd()

# 작업 디렉토리 설정
setwd("~/Teaching/R_basic/2017_7/lec_2/R_script/")

dir()

# 작업공간에 있는 객체(objects) 지우기; rm()는 불필요한 객체를 메모리상에서 제거 
rm(list=ls())

# 사례 
# 
setwd("~/Desktop/basic_space/data/est_19/")

# 시간: 1970년 1월 1일 오전 12시 정각부터 초단위
now <- Sys.time()
now

typeof(now)

class(now)

unclass(now)

mil <- 1000000
mil

class(mil) <- c("POSIXct","POSIXt")
mil

# 요인
gender <- c("male","female","female","male")

gender <- factor(c("male","female","female","male"))

?factor

typeof(gender)
attributes(gender)

# 어떤 식으로 저장하고 있는가?
unclass(gender)

gender

as.character(gender)

card <- c("ace", "hearts", 1)
card

# 강제 변환(벡터에 논리형과 숫자형만 있다면 논리형을 숫자형으로 변환)
sum(c(TRUE, TRUE, FALSE, FALSE))
aa <- c(TRUE, TRUE, FALSE, FALSE)

number1 <- as.character(1)
number2 <- 1

as.logical(0)
as.numeric(FALSE)

# list
list1 <- list(100:130, "R",list(TRUE, FALSE))
list1

card <- list("ace","hearts",1)
card

# dataframe
df <- data.frame(face=c("ace","two","six"),
                 suit=c("clubs","clubs","clubs"),
                 value=c(1,2,3))

df

list(face="ace",suit="hearts",value=1)

# 이 이름들은 객체의 이름 속성에 저장됨
c(face="ace", suit="hearts", value="one")

typeof(df)

class(df)

str(df)


# 각종 파일 불러들임 
# - file(), url()
# - excel, 데이터베이스, XML ...

# csv 텍스트 파일 
# 중요한 것은 csv 파일이 우선 작업 디렉토리에 저장이 되어 있어야 함 
# mydata <- read.table("d:/a.csv", header=TRUE, sep=",", row.names="id")
write.table(mydata, "c:/mydata.txt", sep="\t")

# read.table 대신 read.csv를 사용해도 됨 

# 데이터베이스: records, fields
# 통계: observations, variables
# 기계학습: examples, attributes

# 데이터 타입 list
# - 서로 관련없는 각종 객체 목록(ordered collection of objects)
# - 관련없는 데이터를 함께 모으고자 할 때 사용
# - 주로 함수나 각종 작업의 결과로서 반환되는 데이터의 형태 

n <- c(2,3,5)
s <- c("aa","bb","cc","dd","ee")
b <- c(TRUE, FALSE, TRUE, FALSE, FALSE)
x <- list(n,s,b,3)

x[[1]]

# 항목의 식별은 [[]]

# list 항목의 추가 및  삭제
z <- list(a="abc",b=12)
z

z$c <- c("saling","playing")  # 항목 추가
z

z[[4]] <- c("character","logical")

# 데이터타입 -data frame
# - list의 특수한 케이스 
# column마다 다른 모드(숫자, 문자, factor 등)의 항목을 가짐 

d <- c(1,2,3,4)
e <-c("red","white","red",NA)
f <- c(TRUE, TRUE, TRUE, FALSE)
myframe <- data.frame(d,e,f)
names(myframe) <- c("ID","Color","Passed")   # 변수 명 

#  data frame의 항목 식별 
myframe[1:2,3]
myframe[1:2,c("Color","Passed")]
myframe$Color

# merge two data frames by ID
total <- merge(data frameA, data frameB, by="ID")


# data 정렬
# order()
# - default는 ascending 
# - sorting 변수 앞에 - 표시를 하면 descending order

attach(mtcars)

# sorting by mpg
newdata <- mtcars[order(mpg),]

# sorting by mpg and cyl
newdata <- mtcars[order(mpg,cyl),]

# sorting by mpg(ascending) and cyl(decending)
newdata <- mtcars[order(mpg,-cyl)]

detach(mtcars)

# sort(), order()
v1 <- c(40, 30, 50, 50, 90, 40, 50)
v2 <- c(5100, 6500, 2000, 2000, 9000, 4500, 3000)
v3 <- c("A", "B", "A", "B", "A", "A","B")

v123 <- data.frame(v1, v2, v3)
v123

sort(v1)
sort(v1, decreasing = TRUE) # 내림차순 정렬, default값은 오름차순

order(v1)  #정렬된 색인값을 보여줌
v1[order(v1)] # sort(v1)과 동일한 값
v1[c(2,1,6,3,4,7,5)]

# 데이터 프레임 정렬
v123_order <- v123[order(v1, -v2, v3),] #데이터 프레임 v123 전체행을 v1, v3는 오름차순, v2는 내림차순


v123

v123_order

order(v1, -v2, v3)
row.names(v123_order)

# plyr 패키지 활용
# install.packages("plyr")  # 한 번만 인스톨 하면 됨
library(plyr)
arrange(v123, v1, desc(v2), v3)

# logical index vector
s <- c("aa", "bb", "cc", "dd", "ee")
length(s)

# defining a logical vector
L <- c(FALSE, TRUE, FALSE, TRUE, FALSE)
s[L]

s[c(FALSE, TRUE, FALSE, TRUE, FALSE)]

# R은 모든 문자열을 요인으로 저장함
# 이것을 피하기 위해 stringsAsFactors = FALSE로 설정
data <- read.csv("data_new.csv", header=TRUE, stringsAsFactors = FALSE)
str(data)

# 만약 데이터 셋을 여러 개 불러올 경우 다음과 같이 전역 설정할 수 있음
options(stringsAsFactors = FALSE)
options(stringsAsFactors = TRUE)

# 텍스트 파일 저장하기;  행 이름 변수로 설정해서 저장하는 것 피하기
write.csv(df, "data_ideo.csv", row.names=FALSE)

# 압축 파일
write.csv(df, file=bzfile("~/Teaching/R_basic/2017_7/lec_2/R_script/data_ideo.csv.bz2"),
          row.names=FALSE)

#########################################################################
# importing data
#########################################################################

# (1) importing txt (tab-delimited text) files

dat.1 <- read.table("data.txt", header=FALSE)
dat.1
head(dat.1)
str(dat.1)

dat.2 <- read.table("data.txt", header=FALSE,
                    stringsAsFactors = FALSE)
dat.2
str(dat.2)

dat.1$V3 <- as.character(dat.1$V3)

# (2) importing csv files

# Polity IV라는 정치체제관련 데이터 불러오기

dat.3 <- read.csv("p4v2014.csv", header=TRUE,
                  stringsAsFactors = FALSE)
str(dat.3)

# 2014년 데이터값으로 서브셋 만들기
p4_2014 <- subset(dat.3, year==2012)

# (3) importing excel files
# install.packages("XLConnect")
library(XLConnect)

df <- readWorksheetFromFile("data_2012.xlsx",
                            sheet=1,
                            startRow = 1)
str(df)

wb <- loadWorkbook("data_2012.xlsx")
df <- readWorksheet(wb, sheet=1)
str(df)

# install.packages("xlsx")
library(xlsx)

df <- read.xlsx2("data_2012.xlsx", sheetIndex = 1, startRow=2, colIndex = 2)

# 가장 최근 방법
library(readxl)
data_2012 <- read_excel("여러분의 working directory/data_2012.xlsx")

# (4) importing STATA files
install.packages("foreign")
library(foreign)

dat.4 <- read.dta("WorldData.dta")
str(dat.4)

# 최근 패키지 사용하기
library(haven)
WorldData <- read_dta("WorldData.dta")
View(WorldData)
















