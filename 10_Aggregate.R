
# 데이터 집계 - aggregate
# 특정한 값을 기준으로 그룹화 한 후 다양한 집계 처리

library(googleVis)
Fruits #과일Fruit , 년도Year, 위치Location, 판매액Sales, 비용Expense, 이익Profit, 날짜Date
# 년도별 판매액
aggregate(Sales~Year, Fruits, sum)
# 과일별 총 판매액
aggregate(Sales~Fruit, Fruits, sum)
# 과일별 최고 판매액
aggregate(Sales~Fruit, Fruits, max)
# 과일별 최저 판매액
aggregate(Sales~Fruit, Fruits, min)
# 과일별, 연도별 최저 판매액
aggregate(Sales~Fruit+Year, Fruits, sum)

iris # Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species
# iris 데이터집합에서 종별 꽃받침의 평균 길이는?
aggregate(Sepal.Length~Species, iris, mean)
# iris 데이터집합에서 종별 꽃잎의 평균 길이는?
aggregate(Petal.Length~Species, iris, mean)

install.packages('MASS')
library(MASS)
str(Cars93)

# 차종별 도시와 고속도로의 평균 연비 계산
aggregate(MPG.highway~Manufacturer, Cars93, mean)
aggregate(MPG.city~Manufacturer, Cars93, mean)
# 한번에 출력하고 싶다면 cbind를 쓰면 되지만 귀찮네
MPG <- cbind(MPG.highway = Cars93$MPG.highway, MPG.city = Cars93$MPG.city)
aggregate(MPG~Manufacturer, Cars93, mean)

# tapply : 그룹별로 함수를 적용하는 apply계열 함수
x <- c(1:20)
y <- rep(c(1, 2, 3, 4), 5) 
tapply(x, y ,sum) # x의 값을 y별로 묶어서 sum해라
tapply(x, x %% 2 == 0, sum) # x의 값을 x %% 2 == 0 T/F별로 묶어서 sum해라

# iris에서 종별 꽃받침 평균 길이
tapply(iris$Sepal.Length, iris$Species, mean)
# Fruits 데이터 연도별 총 매출액
tapply(Fruits$Sales, Fruits$Year, sum)