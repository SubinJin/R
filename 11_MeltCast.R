# 데이터 재구성 reshape(reshape2 패키지)
# 데이터를 좀 더 향상된 방식으로 자르고 붙이는 기능 제공
# wide-format data : 데이터 분석시 많이 사용
# long-format data : 다양한 상황에 많이 사용
# melt : 기존 데이터를 long-format data로 변형
# cast : 기존 데이터를 wide-format data로 변형
airquality # 대기질에 관련된 데이터 집합
str(airquality)

# melt : 특정 컬럼을 기준으로 variable(변수)과 value(변수값)를 분리시킴
# 데이터프레임을 다룰 때 데이터 구조를 행의 키를 기준으로 나머지를 변수화해서 
# 하나의 열에 담는 것을 melt, melting이라고 함

# melt(데이터, 기준열)
install.packages('reshape2')
library('reshape2')
air1 <- melt(airquality, id.vars=c('Month', 'Day'))

# melt(데이터, 기준열, 녹일변수)
# 'Month', 'Day'를 기준으로 'Solar.R', 'Wind'를 변수명 컬럼, 값 컬럼에 합쳐서 저장
air2 <- mlet(airquality, id=c('Month', 'Day'), measure=c('Solar.R', 'Wind'))


# mydata 생성하기
ID <- c(1, 1, 2, 2)
Time <- c(1, 2, 1, 2)
X1 <- c(5, 3, 6, 2)
X2 <- c(6, 5, 1, 4)

original <- data.frame(ID, Time, X1, X2)
melted <- melt(original, id=c('ID', 'Time'))
head(original)
head(melted)

# Fruits 데이터를 year기준으로 나머지 데이터를 melt 해보자
yearmelt <- melt(Fruits, id = 'Year')
yearmelt
yearmelt <- melt(Fruits, id = 'Year', 
                 variable.name = 'fruits_type', value.name = 'qty_price')

# melt 된 데이터를 새로운 형식의 데이터로 만들려면 집계함수가 적용거나 그렇지 않은 dcast함수 사용
# dcast(데이터, 기준컬럼~대상컬럼, 적용함수)
dcast(melted, ID~variable, mean) 
dcast(melted, Time~variable, mean)
dcast(melted, ID~Time, mean)
dcast(melted, ID+Time~variable, mean)
dcast(melted, ID+variable~Time, mean)
dcast(melted, ID~variable+Time, mean) # ID, X1_TIME1, X1_TIME2, X2_TIME1, X2_TIME@


# 아까 했던 Fruits도 해보자
# Fruits 데이터를 year, fruit를 기준으로 sales, expense, profit 데이터를 melt 하세요
yearmelt <- melt(Fruits, id = c('Year', 'Fruit'), 
                 measure=c('Sales', 'Expenses', 'Profit'))
yearmelt
yearcast <- dcast(yearmelt, Year~Fruit, mean)
yearcast


dcast(yearmelt, Year~variable)
dcast(yearmelt, Fruit~variable)
dcast(yearmelt, Year+Fruit~variable)
dcast(yearmelt, Year~Fruit+variable)