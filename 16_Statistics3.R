
#실업자 수와 개인 소비 지출의 상관관계 분석
library(ggplot2)
economics
str(economics)
cor(economics$unemploy, economics$pce) # 상관계수 0.6(양의 상관)
cor.test(economics$unemploy, economics$pce)
# p-value가 매우 작기 때문에 상관계수는 유의하다
# 실업자 수unemploy와 개인저축률 psavert의 상관관계 분석

var()
# Cars93 데이터에서 고속도로연비와 차체중량의 상관관계 분석
library(MASS)
Cars93
plot(MPG.highway~Weight, data=Cars93)
abline(lm())
# 음의 상관관계 확인

attach(Cars93)
cor(MPG.highway, Weight) # 공분산을 표준화한 것 - 상관계수
cov(MPG.highway, Weight) # 음수 출력 - 음의 상관관계
detach(Cars93)

cor()
corrplot()

# 자동차의 각요소에 대한 상관관계 분석 - mtcars 이용
head(mtcars)
cor_cars <- cor(mtcars) # 상관행렬 생성
cor_cars <- rount(cor(mtcars), 2) # 소수점 조정
cor_cars # 각 항목에 대한 상관계수 파악 어려움

install.packages('corrplot')
library(corrplot)
corrplot(cor_cars)

# 놀이동산 만족도에 대한 상관분석
# 주말 이용엽, 동반 자녀 수, 공원까지 거리, 기구 만족도, 게임만족도
# 대기시간 만족도, 청결도 만족도, 전체 만족도
play <- read.csv("http://goo.gl/HKnl74")
str(play)

# 그래프 확인
plot(play)

play2 <- play[, c(3:8)] # 주말, 자녀 수 제외
plot(play2)

# 공분산
cov(play2)

# 상관계수
cor(play2)

# 상관 행렬 그래프
corrplot(play2, method='shade')

# 여성의 키와 몸무게 데이터 women
reg <- lm(weight~height,data=women)
reg
plot(women)
abline(reg, col='blue')
summary(reg)

# 자동차 주행속도와 제동거리간의 관계 파악 cars
str(cars)
attach(cars)
plot(speed, dist, col='red')
distsp <- lm(dist~speed)
distsp
abline(distsp, col='blue')

# 놀이기구play 데이터에서 overall과 rides 회귀분석
ovri <- lm(play$overall~play$rides)
plot(play$overall~play$rides)
abline(ovri, col='blue')
summary(ovri)

lm_mult <- lm(play$overall~play$rides+play$games+play$clean)
summary(lm_mlut)
plot(lm_mult)


# 다음 시험점수와 순위로 해당 학교에 입학 가능 여부 확인
# 입합여부, gre(대학졸업점수), gpa(내신성적), 학교등급
# admit : 1 입학성공, 0 입학실패
college <- read.csv('c:/java/college.csv')
# rank는 이산형 데이터이므로 범주형 변수로 변환
range(college$rank) # 1 ~ 4
college$rank <- as.factor(college$rank)

#회귀식 분석
attach(college)
glm_college <- glm(admit~gre+gpa+rank, family='binomial')
summary(glm_college)


# 유럽 21개 도시 간의 거리를 측정한 데이터
library(MASS)
data(eurodist)

# 각 도시정보를 2차원으로 정리
citydist <- cmdscale(eurodist)
citydist

#도시 정보를 x, y로 맵핑
x <- citydist[, 1]
y <- citydist[, 2]

# 지도에 도시정보 출력
plot(x, y)
text(x, y, rownames(citydist), cex=0.8)
abline(v=0, h=0, lty=2, lwd=1.2)


y <- -citydist[, 2] 
# y축을 뒤집어줌
plot(x, y)
text(x, y, rownames(citydist), cex=0.8)
abline(v=0, h=0, lty=2, lwd=1.2)


# 자동차에 대한 선호도 조사를 다차원척도법으로 분석
# 5대의 차종에 대한 호감도를 1 ~ 9 사이의 점수로 평가
set.seed(298374) # 난수 생성
qmatrix <- matrix(sample(c(1:9), 25, replace=T), nrow=5, ncol=5)
# 설문조사내용을 난수로 만들어 행렬에 저장
car_names = c('Ferrari', 'jaguar', 'volkswagen', 'genesis', 'bmw')
colnames(qmatrix) <- car_names
rownames(qmatrix) <- car_names
# 행렬에 행제목과 열제목 작성

qm <- dist(qmatrix)
qm <- cmdscale(qm)
plot(qm, type = 'p')
abline(h=0, v=0, col='red')


qmatrix <- matrix(rnorm(100), nrow=5)
dist(qmatrix)
qm <- dist(qmatrix)
qm <- cmdscale(qm)
plot(qm, type = 'p')
abline(h=0, v=0, col='red')
text(qm, c(rownames(qmatrix)))