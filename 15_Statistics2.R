
# 기술통계 관련 함수
length(mtcars) # 데이터 객체의 요소(변수) 갯수
nrow(mtcars) # 행 수
ncol(mtcars) # 열 수
str(mtcars) # 데이터 구조(structure), 변수 ghkrdls
head(mtcars) # 상위 6개
tail(mtcars) # 하위 6개

install.packages('car')
library(car)
some(mtcars) # 무작위 관측치 보기기보측츠관
names(mtcars) # 데이터 변수 이름
class(mtcars) # 데이터 원소의 속성

# 데이터 요약
min() # 최소
max() # 최대
mean() # 평균
median() # 중앙값
sd() # 표준편차
var() # 분산
range() # 범위
quantile() # 사분위 수

summary() 
# 최대/ 최소, 평균, 중앙, 사분위값
apply(mtcars, 2, mean)
# apply(데이터, 행/ 열, 함수) : 집계함수를 이용한 데이터 요약


install.packages('fBasics')
library(fBasics)
skewness(mtcars$mpg)
hist(mtcars$mpg, freq=F)
lines(density(mtcars$mpg), col='red', lwd=2)


library(MASS)
with(Cars93, tapply(Price, Type, skewness))
# Cars93의 차종별 가격에 대해 왜도 측정


# 일별 출근 소요시간에 따른 분위수 계산
data <- c(30, 29, 32, 38, 29, 36, 34, 36, 31, 30)
# 4분위수
quantile(data)
# 백분위수
quantile(data, 0.1)
# 분위수 그래프
qqnorm(data)
qqline(data)


# 줄기-잎 그래프 : 표형태와 그래프형태의 혼합
stem(Cars93$MPG.highway)
stem(Cars93$MPG.city)
# Yellowstone 국립공원 간헐철 data
str(faithful)
faithful
stem(fithful$eruptions)


t.test()
# A회사의 금년도 대졸자 초임을 조사하기 위해 15명의 표본을 뽑았다.
# 평균 임근에 대한 95% 신뢰구간을 구하라
sal <- c(165, 159, 170, 168, 170, 172, 167, 158, 170, 171, 164, 165, 168, 167, 171)
t.test(sal)
# 공장에서 생산되는 소금의 평균무게를 신뢰구간 95%, 99%로 추정하자
salt <- c(102, 103, 104, 103, 105, 104, 101, 103, 102, 104, 104, 103, 105, 104, 101)
t.test(salt)
t.test(salt, conf.level=0.99)

#        One Sample t-test
#
# data:  salt
# t = 315.98, df = 14, p-value < 2.2e-16
# (t 통계량)   (자유도)  (p 값)
# alternative hypothesis: true mean is not equal to 0
# 99 percent confidence interval:
#  102.2278 104.1722 (신뢰구간)
# sample estimates:
# mean of x 
#     103.2 (평균)

chisq.test()


prop.test()
# 어느 상표에 대한 선호도를 조사한 결과 100명중 48명이 이 상표를 선호하는 것으로 나타남
# 90%, 95% 신뢰구간은?
prop.test(48, 100) # 신뢰구간 default값 95%
prop.test(48, 100, conf.level=0.9) # 90% 신뢰구간
# 어떤 대학의 학생 1350명 중 620명이 흡연자
# 95%, 99% 신뢰구간?
prop.test(620, 1350)
prop.test(620, 1350, conf.level=0.99)


# 귀무 : 신약은 특효가 없다
# 대립 : 신약은 특효가 있다
x1 <- c(13.2, 8.2, 10.9, 14.3, 10.7, 6.6, 9.5, 10.8, 8.8, 13.3) # 기존 혈당
x2 <- c(14.0, 8.8, 11.2, 14.2, 11.8, 6.4, 9.8, 11.3, 9.3, 13.6) # 신약 투여 후 혈당
# 각각의 평균/분산의차 계산
t.test(x1, x2, paired=T)

#         Paired t-test
#
# data:  x1 and x2
# t = -3.3489, df = 9, p-value = 0.008539
#                      (위험도p : 기준가설을 기각해도 틀릴 확률)
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#  -0.6869539 -0.1330461
# sample estimates:
# mean of the differences 
#                  -0.41 


# A 회사 직장인 500명과 B 회사 직장인 600명을 대상으로 흡연율이 각각 32%, 41%가 조사됐다
# A 회사의 흡연율과 B 회사의 흡연율에는 차이가 있는가?
# 유의수준 5% 내에서 검증

# h0 : A, B 회사의 흡연율은 같다
# h1 : A, B 회사의 흡연율은 다르다
x5 <- c(0.33, 0.41) # 흡연율
x6 <- c(500, 600) # 조사 인원수
event <- x5*x6 # 흡연 발생율
prop.test(event, x6)


x <- c(3, 5, 8, 11, 13)
y <- c(1, 2, 3, 4, 5)
cor(x, y)
# 상관계수 r : 반비례 -1 <= r <= 1 정비례, r=0 상관 없음 


# iris에서 꽃받침, 꽃잎의 너비/길이에 대한 상관계수 계산
cor(iris$Sepal.Length, iris$Petal.Length)
cor(iris$Sepal.Length, iris$Petal.Width)
cor(iris$Sepal.Width, iris$Petal.Length)
cor(iris$Sepal.Width, iris$Petal.Width)

cor(iris[, c(1:4)]) # better
    
    
airquality
airs <- airquality[, c(1:4)]
airs <- na.omit(airs) # 결측치 제거
airs
cor(airs)

plot(airs)
plot(airs[, c(1:4)]) # 동일

plot(airs$Ozone)
abline(airs$Ozone, 1:150)
abline(airs$Ozone/150, 1:150)
