#################################################################################
#
# script_1.R
#
# 7/31/2017
# 8/1/2017 중요 함수 수정
# by 구본상
#
#################################################################################

# 작업 디렉토리 확인
getwd()

# 작업 디렉토리 설정
setwd("~/Teaching/R_basic/2017_7/lec_1/R_script/")

dir()

# 작업공간에 있는 객체(objects) 지우기; rm()는 불필요한 객체를 메모리상에서 제거 
rm(list=ls())

# 사례 
# 
setwd("~/Desktop/basic_space/data/est_19/")

###################################################################
# R 객체 이해하기
###################################################################
# 원자 벡터: 단순한 벡터 형태의 데이터를 의미
die <- c(1,2,3,4,5,6)
die

# 객체가 원자 벡터인지 확인하는 방법. 해당 객체가 원자 벡터일 경우 TRUE, 
# 아닐 경우 FALSE를 돌려준다
is.vector(die)
is.matrix(die)

five <- 5
five

is.vector(five)

# 원자 벡터의 길이 length() 함수
length(five)

length(die)

# 각 원자 벡터는 값을 일차원 벡터로 저장, "동일한" 자료형의 데이터만 저장 가능
# 실수형(double), 정수형(integer), 논리형(logical),
# 복소수형(complex), 원시형(raw) 6가지 기본적 자료형 원자 벡터 가능

# 정수형 벡터 만들기 "L" 사용
int <- 1L

# 문자형 벡터 만들기
text <- "text"

# 두 개 이상 원소를 가질 때 c() 사용
int <- c(1L, 5L)
text <- c("ace", "hearts")

# 숫자가 담긴 원자 벡터로는 사칙연산이 가능하지만 문자열이 담긴 경우 불가능
sum(int)

sum(text)

int <- c(1,5)

# (1) 실수형: 일반적으로 R은 어떤 숫자든 실수형을 저장
die <- c(1,2,3,4,5,6)
die

# 정확한 자료형 확인 typeof() 사용
typeof(die)

# 숫자형(numeric) = 실수형

# (2) 정수형: L이 없으면 정수형을 저장하지 않고 실수형으로 저장됨
int <- c(-1L, 2L, 4L)

int <- c(-1, 2, 4)

typeof(int)

# 실수형은 유효숫자는 16개
sqrt(2)^2-2

# (3) 문자형
text <- c("Hello", "World")
text

typeof(text)

# (4) 논리형: TRUE or FALSE; T와 F로 사용 가능
3 < 4
3 > 4

logic <- c(TRUE, FALSE, TRUE)
logic

typeof(logic)

typeof(F)


# (5) 복소수형과 원시형
comp <- c(1 + 1i, 1 + 2i, 1 + 3i)
comp

typeof(comp)

# 원시형 벡터는 원래 바이트 정보를 그대로 저장
# raw(n)으로 길이가 n인 빈 원시형 벡터 만들 수 있음

raw(3)

typeof(raw(3))
?raw

# 이름을 저장하기에는 문자열이 가장 적합한 원자 벡터
hand <- c("ace", "king", "queen", "jack", "ten")
hand

typeof(hand)

# 속성(attributes): 원자 벡터에 붙일 수 있는 일종의 정보
#                  객체 값에 아무런 영향을 주지 않음

attributes(die)

# 속성: 이름(names), 차원(dim), 클래스(class)

names(die)

names(die) <- c("one","two","three","four",
                "five","six")

attributes(die)

die

die + 1

names(die) <- c("uno", "dos", "tres", "cuatro", "cino", "seis")
die

names(die) <- NULL
die 

# 차원
dim(die) <- c(2,3)
die

dim(die) <- c(3,2)
die

# 3차원(hypercube)
dim(die) <- c(1,2,3)
die

length(die)

# 행렬(matrix)
m <- matrix(die, nrow=2)
m

# by column임. byrow = FALSE 가 default 값
m <- matrix(die, nrow=2, byrow=TRUE)
m

# 배열(array)
ar <- array(c(11:14, 21:24, 31:34), 
            dim=c(2,2,3))
ar

hand1 <- c(1,"king","queen","jack",
           "ten","spades","spades",
           "spades","spades","spades")
matrix(hand1, nrow=5, byrow=TRUE)
matrix(hand1, ncol=2)
dim(hand1) <- c(5,2)
hand1

# 자료형 확인
typeof(die)

class(die)

class(hand1)

# 클래스: 객체의 차원을 바꾸면 객체의 자료형, 즉 종류가 변경되지는 않지만
# 클래스 속성은 바뀐다
dim(die) <- c(2,3)
typeof(die)

class(die)

attributes(die)

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

as.character(1)
as.logical(1)
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

# 연산
x=5; y=2
x+3
x+y
print(x+y)
x = pi
x
rm(x)
mydata <- data.frame(age=numeric(0), gender=character(0),
                     weight=numeric(0))
mydata <- edit(mydata)

# mtcars 데이터 사용하여 특정 칼럼(변수)만 불러오기 
mtcars$mpg

mydata$x1 <- c(10,20)
mydata$x2 <- c(30,20)
mydata$sum <- mydata$x1 + mydata$x2
mydata$mean <- (mydata$x1 + mydata$x2)/2

# attach와 detach 사용하기
attach(mydata)
mydata$sum <- x1 + x2
mydata$mean <- (x1 + x2)/2

mydata <- transform (mydata,
                     sum = x1 + x2,
                     mean = (x1 + x2)/2)

# c(): concatenate, 벡터에 사용 
x <- c(1,2,4)    
x
q <- c(x,8,100000)
q

x[2:3]   # subsetting (sub-vector)
mean(x)
y <- sd(x)
y 

# 각종 파일 불러들임 
# - file(), url()
# - excel, 데이터베이스, XML ...

# csv 텍스트 파일 
# 중요한 것은 csv 파일이 우선 작업 디렉토리에 저장이 되어 있어야 함 
mydata <- read.table("d:/a.csv", header=TRUE, sep=",", row.names="id")
write.table(mydata, "c:/mydata.txt", sep="\t")

# read.table 대신 read.csv를 사용해도 됨 

# 데이터베이스: records, fields
# 통계: observations, variables
# 기계학습: examples, attributes

# 데이터 셋 
# - 여러 관측값을 가지는 것 
# 

Rev_2012 = c(111,105,120,140)     # 예: 분기별 매출 
Rev_2013 = c(105,115,140,135)     
Revenue = rbind(Rev_2012, Rev_2013)

# R에서의 데이터 타입: data frame에서는 열마다  data mode가 다를 때 사용할 수 있음 
x <- 5
x
mode(x)

y <- "대한민국"
mode(y)

z <- c("대한민국", "우편번호", 135)
mode(z)

z.1 <- data.frame("대한민국", "우편번호", 135)

y <- "abc"
mode(y)

# 데이터 형태의 변환 
# - 데이터 형태의 확인
# is.numeric(); is.character(); is.factor()
# as.numeric()

family = c("아버지","어머니","딸","아들")
family

x = -5:3
x

# 논리식 적용 
w = x < -2
w
# 연산자
# seq(): 수열 생성
# rep(): 
rep(1,1000)

a <- c(1,2,3,6,-2.4)
a[c(2,4)]          # 2번째와 4번째 항목 
new_a <- a[-2]     # 2번째 항목 제외
new_a

5:8
5:1

seq(12,30,3)
seq(from=12, to=30, by=3)

x <- rep(5,3)
x

u <- c(5,2,8)
v <- c(1,3,9)
u > v

# 함수 지정 
w <- function(x)  return(mean(x)+3)
w(u)
u
w(u)

y <- c(2.233342, 4.33233, 5.797866)
round(y,2)

# vector 연산 (vectorization)
# Vector In, Matrix Out
ans_sqd <- function(z) return(c(z,z^2))
x <- 1:4
ans_sqd(x)

matrix(ans_sqd(x), ncol=2)
ans_sqd2 <- function(z) return(c(z,z^2))
sapply(x, ans_sqd2)

# recycling
c(1,2) + c(5,6,7,8)

# filtering
z <- c(5,3,-2,0,1,10)
w <- z[z > 0]
w

subset()

# NA와 Null
# - NA 결측치 (missing value)
# - Null: undefined value(적절한 값이 존재하지 않음)
# - NaN: Not a Number
x <- 0
y <- 0
z <- x/y

x <- matrix(1:6, ncol=3)
x 
x + c(1,2)

# matrix
# mymatrix <- matrix(vector, nrow=r, ncol=c, byrow=FALSE,
#                    dimnames=list(char_vector_rownames, char_vector_colnames))

y <- matrix(1:20, nrow=5, ncol=4)

cells <- c(1,26,24,68)
rnames <- c("R1","R2")
cnames <- c("C1","C2")
mymatrix <- matrix(cells, nrow=2, ncol=2,
                   byrow=TRUE,
                   dimnames = list(rnames, cnames))

x[,4]    # matrix 4째 column
x[3,]    # matrix 3째 row
x[1:2, 2:3]   # 2,3,4번 row의 1,2,3번 column

# matrix의 row와 column에 함수를 적용하기
# - apply() 함수 
# apply(m, dimcode, f, fargs)
# - m = matrix
# - dimcode = 1; row에 적용; 2: column에 적용 
# - f: 적용할 함수, fargs = optional arguments

m <- matrix(c(1:10), nrow=5, ncol=2)
# row별 평균 
apply(m, 1, mean)
apply(m,1,sd)

# column별 평균 
apply(m, 2, mean)

# 각 항목을 2로 나눔 
apply(m, 1:2, function(x) x/2)

mydata <- matrix(rnorm(30), nrow=6)
mydata
apply(mydata, 1, mean)
apply(mydata, 2, mean)
apply(mydata, 2, mean, trim=0.2)  # 상위, 하위 20% 제외한 중위 부분 보여준다 

# matrix 변경
x <- matrix(c(12,3,7,16,4))
x <- c(x,15)
x

B <- matrix(c(2,4,3,1,5,7), nrow=3, ncol=2)
C <- matrix(c(7,4,2), nrow=3, ncol=1)
cbind(B,C)

# matrix와 vector와의 관계 
# - matrix는 vector와 matrix의 고유한 성질 
z <- matrix(1:8, nrow=4)
z 
length(z)
class(z)
attributes(z)

# 데이터 타입 array
# - 3차원 이상의 항목을 가진다 

x <- array(1:36, c(4,3,3))
x
x[1,,]
x[,,1]

# 데이터 타입 list
# - 서로 관련없는 각종 객체 목록(ordered collection of objects)
# - 관련없는 데이터를 함께 모으고자 할 때 사용
# - 주로 함수나 각종 작업의 결과로서 반환되는 데이터의 형태 

n <- c(2,3,5)
s <- c("aa","bb","cc","dd","ee")
b <- c(TRUE, FALSE, TRUE, FALSE, FALSE)
x <- list(n,s,b,3)

x[[3]]

# 항목의 식별은 [[]]

# list 항목의 추가 및  삭제
z <- list(a="abc",b=12)
z

z$c <- "saling"  # 항목 추가
z

z[[4]] <- 28

# list에 사용되는 함수 lapply(), sapply() 적용 
lapply(list(2:5, 35:39), median)
sapply(list(2:5, 35:39), median)   # 결과가 vector 또는 matrix인 경우 

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
myframe[c("ID")]
myframe$Color

# merge two data frames by ID
total <- merge(data frameA, data frameB, by="ID")

# 함수 적용: apply(), sapply()

# 데이터 타입 - factor
x <- c(5,12,13,12)
xf <- factor(x)
xf
str(xf)
length(xf)

# rating <- ordered(rating)

# factor에 유용한 함수 
# tapply(): vector를 그룹별로 나눈 후 지정한 함수를 적용 
ages <- c(25,26,34,43,57)
party <- c("새누리","민주","민주","새누리","기타")
tapply(ages, party, mean)

# split()
g <- c("M","F","M","I","M","F","I")
split(1:7,g)

# 분할표(contingency table)
trial <- matrix(c(34,11,9,32), ncol=2)
colnames(trial) <- c("sick","healthy")
rownames(trial) <- c("risk","no_risk")
trial.table <- as.table(trial)
trial.table 

# 기타 dataset에 대한 정보 획득 
# ls() : objects목록 출력
# names(mydata) : mydata에 있는 변수 목록 
# str(mydata)
# levels(mydata$v1)
# dim(object)
# class(object)
# mydata
# head(mydata, n=10)
# tail(mydata, n=5)

# 연산자(operators)
# x %% y: 나머지 (x mod y)
# x %/% y: integer division

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
v3 <- c("A", "B", "A", "B", "A", "A", "B")

v123 <- data.frame(v1, v2, v3)
v123

sort(v1)
sort(v1, decreasing = TRUE) # 내림차순 정렬, default값은 오름차순

order(v1)  #정렬된 색인값을 보여줌
v1[order(v1)] # sort(v1)과 동일한 값

# 데이터 프레임 정렬
v123_order <- v123[order(v1, -v2, v3),] #데이터 프레임 v123 전체행을 v1, v3는 오름차순, v2는 내림차순


v123

v123_order

order(v1, -v2, v3)
row.names(v123_order)

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
data <- read.csv("data_new.csv", header=TRUE, stringsAsFactors = FALSE)
str(data)

# 만약 데이터 셋을 여러 개 불러올 경우 다음과 같이 전역 설정할 수 있음
options(stringsAsFactors = FALSE)
options(stringsAsFactors = TRUE)
