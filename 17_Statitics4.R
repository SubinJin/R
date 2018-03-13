
# 유사부류 찾기 - 거리 개념 이용(유클리드 거리행렬)
# 학업집중도에 따라 학생 반편성 해보기
academy <- read.csv('c:/java/academy.csv', stringsAsFactors=F)
head(academy) 
str(academy)
aca <- dist(academy) # 유클리드 거리행렬 계산
aca_xy <- cmdscale(aca) # 2차원 좌표형식으로 전환
plot(aca_xy)
text(aca_xy, as.character(1:52))
# 고객들이 선호하는 음식메뉴 유사성 알아보기
food <- read.csv('c:/java/food.csv')
head(food)
str(food)
distfood <- dist(food)
food_xy <- cmdscale(distfood)
plot(food_xy)
text(food_xy, colnames(food))
# 18번 고객이 선택한 추어탕1, 갈비탕1 간의 거리 : 0
# 2번 고객이 선택한 추어탕0, 갈비탕0 간의 거리 : 0
# 즉, 추어탕, 갈비탕을 선택한 고객과 추어탕, 갈비탕을 선택하지 않은 고객이 같은 결과값
# 가중치를 줘서 문제를 해결하자

food2 <- read.csv('c:/java/food.csv')
food2 <- food2[-1] # 1열 제외
food2 <- t(as.matrix(food2)) %*% as.matrix(food2) 
# 기존 데이터를 행렬로 전환
# 거리계산이 제대로 되도록 자기자신을 한번 더 곱함
head(food2)
foo2 <- dist(food2)
food2_xy <- cmdscale(foo2)
plot(food2_xy, type='n')


# 김치 판매량에 대한 시계열 예측하기
kimchi <- read.csv('c:/java/kimchi.csv')
attach(kimchi)
plot(대형마트수량, type='l', xlab='주', ylab='금액')
plot(편의점수량, type='l', xlab='주', ylab='금액')
# 그래프 합치기
library(zoo)
dates <- as.Date(as.character(주마지막일자), format='%Y%m%d')
all_sales <- data.frame(cbind(대형마트수량, 백화점수량, 수퍼수량, 편의점수량))
z_sales <- zoo(all_sales, dates)
plot(z_sales, screens=1, xlab='날짜', ylab='판매량', 
     col=c('red', 'green', 'blue', 'purple'))

plot(z_sales, screens=1:4, xlab='날짜', ylab='판매량', 
     col=c('red', 'green', 'blue', 'purple'))


# 마지막 년도를 기준으로 잘라서 추세를 그래프로 확인
sales_2015 <- zoo(all_sales, dates)
kimchi2015 <- read.csv('c:/java/kimchi2.csv')
k_sales <- zoo(kimchi2015$SALES, as.Date(as.character(kimchi2015$LAST_WK), 
                                         format='%Y%m%d'))
merge_2015 <- merge(k_sales=window(sales_2015, start='2015-01-01', end='2015-12-31'),
                    k_sales, all=F)
head(merge_2015)
plot(merge_2015)


# 각 그래프 간의 상관관계 알아봄
ccf(k_sales, windows(sales_2015, start='2015-01-01', end='2015-12-31'),
    main='판매량 상관관계')

# 대형마트 판매량을 기준으로 시간에 따른 변화량 확인 - 차분
bigsales <- zoo(kimchi$대형마트수량, dates)
plot(bigsales)
# 현재의 매출은 과거의 매출과 상관관계가 있나?
# 자기상관관계 함수 acf
acf(bigsales)
# 이러한 자기상관이 김치 시계열에 존재하나?
# 자기상관에 대한 검증 실시 : p값 조사
Box.test(bigsales) # Box-Pierce 검증
Box.test(bigsales, type='Ljung-Box') # Box-Ljung 검증


# 이동평균법으로 시계열 그래프를 좀 더 부드럽게 표시
plot(bigsales)
par(mfrow=c(1, 4))
roll2 <- rollapply(big_sales, 2, mean)
roll4 <- rollapply(big_sales, 4, mean)
roll6 <- rollapply(big_sales, 6, mean)
roll8 <- rollapply(big_sales, 8, mean)
plot(roll2)
plot(roll4)
plot(roll6)
plot(roll8)

# 이동평균의 묶음width 수는 얼마가 좋을까?
# acf를 통해 구한 자기상관수를 사용하자
par(mfrow=c(1, 1))
roll11 <- rollapply(bigsales, 11, mean)
plot(roll11)


# 예측값 계산 - 시계열 모형 생성 : ARIMA 모델
# R에서는 auro.arima라는 만능함수를 사용
install.packages('forecast')
library(forecast)
fit1 <- auto.arima(ts(log(bigsales), frequency=52))
# frequency : 주 단위
plot(forecast(fit1))

fit2 <- auto.arima(ts(log(bigsales), frequency=52), seasonal=T)
plot(forecast(fit2))


# 생성된 모형으로 값 예측
v <- predict(fit2, n.ahead=10)
v <- predict(fit2, n.ahead=20)
# 향후 10주, 20주 동안 마트 판매량 예측


# 가게에 찾아오는 고객에 설문지를 돌려 인적사항이나 개인정보를 조사하면서 할인쿠폰을 준다고 가정
# 이때, 할인쿠폰에 대한 반응도를 Y/N으로 구분하고 어떤 패턴을 가진사람이 패턴을 선호하나 관찰
skin <- read.csv('c:/java/skin.csv')
summary(skin)
head(skin)
str(skin)
library(rpart)
tree1 <- rpart(쿠폰반응여부~., data=skin, control=rpart.control(minsplit=2))
plot(tree1, compress=T, uniform=T)
text(tree1, use.n=T, col='blue')


# 타이타닉에서 살아남을 사람은 누구인가?
# http://titanic-survivor.herokuapp.com

# CART 알고리즘을 사용하는 tree 패키지 적용
install.packages('tree')
library(tree)
skin2 <- tree(쿠폰반응여부~., data =skin)
plot(skin2)
text(skin2)
# skin의 각 변수에 대해 쿠폰반응여부 확인
xtabs(~결혼여부, data=skin)
chisq.test(xtabs(~결혼여부, data=skin))

# 다른 변수
xtabs(~성별 + 쿠폰반응여부, data=skin)
xtabs(~차량보유여부 + 쿠폰반응여부, data=skin)
xtabs(~직장여부 + 쿠폰반응여부, data=skin)

# 의사결정나무 비율(가중치) 확인
tree1
install.packages('partykit')
ctree


academy <- read.csv('c:/java/academy.csv')
academy
library(cluster)

aca_dist <- dist(academy)^2
hcl <- hclust(aca_dist, method='single') # 최단거리
plot(hcl, hang=-1, xlab='학생', ylab='거리')

hcl2 <- hclust(aca_dist, method='complete') # 최장거리
plot(hcl2, hang=-1, xlab='학생', ylab='거리')

hcl3 <- hclust(aca_dist, method='average') # 평균거리
plot(hcl3, hang=-1, xlab='학생', ylab='거리')


# 비통계적 군집방법 : k-means 군집
kms4 <- kmeans(academy, 4) 
kms4
kms5 <- kmeans(academy, 5) 
kms5
kms6 <- kmeans(academy, 6)
kms6
# Cluster means : 각 군집의 중심점(평균값)
# Clustering vector : 각 요소의 군집 분류번호

# 군집화된 결과를 그래프로 표시
plot(academy, col=kms4$cluster)
plot(academy, col=kms5$cluster)
plot(academy, col=kms6$cluster)
text(food2_xy, colnames(food2))