# 비복원 추출
sample(1:100, 5, replace=F)
# 복원 추출
sample(1:100, 5, replace=T)
# 비복원 층화 추출 - 계층을 대표하는 표본 추출
install.packages('sampling')
library(sampling)
data(iris)
x <- stratra(c('Species'), size=c(2, 2, 2), method='srswor', data=iris)
getdata(iris, x)
# 복원 층화추출 
x <- stratra(c('Species'), size=c(2, 2, 2), method='srswr', data=iris)
getdata(iris, x)
# 계통 추출 - sampleBy(식, 추출비율, 복원추출여부)
install.packages('doBy')
library(doBy)
x <- data.frame(1:100)
sampleBy(~1, frac=.1, data=x, systematic=T)
# 종별로 10%씩 추출
sampleBy(~Species, frac=.1, data=iris)


# 동전 던지기
sample(c('앞', '뒤'), size=10, replace=T)
# 동전 던지기 가중치 50% 이런걸 왜 하지?
sample(c('앞', '뒤'), size=10, replace=T, prob=c(0.5, 0.5))


# b(20, 0,5)
x <- dbinom(0:20, size=20, prob=0.5)
plot(0:20, x, type='h', lwd=5, col='blue', 
     ylab='확률', xlab='확률변수', main='베르누이 시행 이항분포')
# 동전 4번 던져서 앞이 나올 분포
y <- dbinom(0:4, size=4, prob=0.5)     
plot(0:4, y, type='h', lwd=5, col='blue', 
     ylab='확률', xlab='앞이 나올 횟수', main='베르누이 시행 이항분포')
# 교통사고 10중 6이 음주운전일때 8중 6일 확률은?
z <- dbinom(6, size=8, prob=0.6)
plot(6, z, type='h', lwd=5, col='blue',
     ylab='확률', xlab='음주운전 횟수', main='베르누이 시행 이항분포')


# x번 째에 어떤 사건이 일어날 확률 ex) 7번째에 주사위 눈금 5가 나올 확률
# 승부차기 확률 계산 : 성공률이 0.2일때 평균 몇번을 차야 첫골이 들어갈까?
set.seed(7829)
goal <- c(1, 0 ,0 ,0, 1, 0, 0, 0, 0, 0)
sample(goal, 1)
goals <- sample(goal, 100, replace=T) # 횟수만큼 시행 - 복원 추출
goals
getGoals <- function(n, r){
  count <- 0 # 시행 중 성공한 건수
  for(i in 1:n){
    g <- sample(goal, r, replace=T) # r 횟수만큼 복원추출
    # 최초 성공
    if(sum(g) == 1 && g[r] ==1){
      count <- count + 1
    }
  }
  return(count) # 결과 반환
}
test <- getGoals(1000, 1) # 1000번 차서 1번에 성공한 횟수
test
# 기하 분포를 그래프로 표시
times <- sum(goalCount)
rel_goals <- goalCount / times
plot(rel_goals)


# 어떤 사건의 평균 발생 횟수가 3일 때 포아송 분포 그래프
a <- c(0:10)
b <- dpois(a, lambda=3)
plot(b, type='h', main='람다가 3인 포아송 분포')
# 어느 은행의 시간당 평균 방문고객이 3인 포아송 분포를 따를 때 시간당 고객이 5일 확률
dpois(5, lambda=3)
# 어느 은행의 시간당 평균 방문고객이 20인 포아송 분포를 따를 때 시간당 고객이 15일 확률?
dpois(15, lambda=20)
# 누적시키키
sum(dpois(c(0:10), lambda=20))
ppois(10, lambda=20, lower.tail=T)
# 평균 사건발생횟수가 20인 포아송분포를 이용해서 난수 1000개를 만들고 히스토그램
rpois(1000, lambda=20)
hist(rpois(1000, lambda=20))


install.packages('ggplot2')
library(ggplot2)
x <- c(-2:20)
ggplot(x, aes(x=x)) + 
  stat_function(fun=dunif, args=list(0, 10), color='black', size=1) +
  ggtitle('최소값 1, 최대값 10의 균등분포')


x <- seq(-3, 3, length=200)
plot(x, dnorm(x, mean=0, sd=1), type='l', main='평균이 0, 편차가 1인 정규분포')
# 평균이 50, 표준편차가 4인 정규분포로부터 난수 100개 발생
rnorm(1, mean=50, sd=4)
rnorm(100, mean=50, sd=4)
hist(rnorm(100, mean=50, sd=4))
hist(rnorm(1000, mean=50, sd=4)) # n이 커질수록 정규분포의 모형과 근사

# 평균이 0, 편차가 1인 정규분포에서 Z값이 -1.5일 확률과 그래프
rnorm(1)