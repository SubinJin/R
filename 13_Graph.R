
# 숫자와 텍스트만으로 작성된 통계결과는 지루 / 따분
# 그래프와 그림형태로 제시(시각적 묘사) - Good
# 그래프 그리기 함수 : plot(x, y), plot(y ~ x)
x <- (1:10)
y <- (10:1)
plot(x, y)

x <- (-5:5)
y <- 3*x + 5
plot(x, y)

x <- (1:10000)
y <- sqrt(x)
plot(x, y)

x <- (1:100)
y <- log(x)
plot(x, y)

plot(rnorm(15))
hist(rnorm(15))
boxplot(rnorm(15))

#그래프 출력방향 지정 - sink()
bmp('c:/Java/graph.jpg') # 그래프를 jpg 확장자로 저장(왠지 bmp, png는 안됨)
attach(mtcars)
plot(wt, mpg) # x축 중량, y축 연비 / 산점도
abline(lm(mpg~wt)) # 상관관계를 의미하는 직선 추가
title('차량 중량에 따른 연비의 상관관계')
detach(mtcars)
sink() # 작성한 내용을 지정한 장치로 전달
dev.off() # sink 해제


# 그래프 그리기 사례
# 두 약물에 따른 환자 반응
dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
plot(dose, drugA, type='p') # 점(default값이 p임)
plot(dose, drugA, type='l') # 선
plot(dose, drugA, type='h') # 수직선
plot(dose, drugA, type='s') # 계단식
plot(dose, drugA, type='S') # 계단식

# 그래프 옵션 설정 - par()
# pch : 점 종류 (0 ~ 25)
# lty : 선 종류 (1 ~ 6)
# cex : 기호 크기 1, 1.5, 0.5
# lwd : 선 굵기 1, 1.5, 0.5
par(lty=2, pch=17, lwd=3, cex=3)
plot(dose, drugB, type='b')

plot(dose, drugB, type='b', lty=4, pch=5) # 이렇게 한방에 할 수도 있음

par(bg='light cyan')  # 그래프 배경
plot(dose, drugB, type='b')

# col 색, fg 전경색
plot(dose, drugA, col='red', col.axis='blue', coo.lab='green', main='메인제목', col.main='purple', sub='서브제목', col.sub='navy', fg='orange')


# 그래프에서 사용 가능한 색상 조회 - colors()
colors()
# 인기색
colors1 <- rainbow(10)
colors2 <- heat.colors(10)
colors3 <- topo.colors(10)
colors4 <- cm.colors(10)
colors5 <- gray(0:10/10)

plot(1:10, 10:1, col=colors1)
plot(1:10, 10:1, col=colors2)
plot(1:10, 10:1, col=colors3)
plot(1:10, 10:1, col=colors4)
plot(1:10, 10:1, col=colors5)

# iris에서 종별(Species)로 색상을 지정해서 산점도 출력
attach(iris)
plot(Petal.Width~Sepal.Width, iris, xlab='Sepal 길이', ylab = 'Petal 너비', main = 'iris 샘플링', col=c('red', 'blue', 'green')[Species])
detach(iris)


# 원 그래프(파이)
pie(rep(1:10), labels=colors1, col=colors1)
pie(rep(1:10), labels=colors2, col=colors2)
pie(rep(1:10), labels=colors3, col=colors3)
pie(rep(1:10), labels=colors4, col=colors4)
pie(rep(1:10), labels=colors5, col=colors5)

windowsFonts(
  A = windowFont("궁서체"),
  B = windowsFont("Consolas"),
  C = windowsFont("맑은 고딕")
)
# 폰트 : 1 기본, 2 진하게, 3 이탤릭, 4 진하고 이탤릭
par(mfrow=c(1, 1)) # 그래프 옵션 초기화
par(font.lab=3, font.main=4, font.axis=2, family='B') # A, B, C 글씨체 바뀜
plot(dose, drugA, type='b', main='폰트 연습')
     
     # 범례 - legend(위치, 제목, 범례...)
     install.packages('Hmisc') # 그래프에 작은 눈금을 그림
     library(Hmisc)
     minor.tick(nx=3, ny=3, tick.ratio=0.5)
     par(mfrow=c(1, 1))
     plot(dose, drugB, type='b', pch=15, lty=1, col='red', ylim=c(0, 60), main='환자와 약물A의 관계', xlab='환자', ylab='약물 반응')
     line(dose, drugB, type='b', pch=17, lty=2, col='blue')
     abline(h=c(30), lwd=1.5, lty=2, col='gray') # 보조선
     
     legend('topleft', inset=0.05, title='약물 종류', c('A', 'B'), lty=c(1, 2), pch=c(15, 17), col=c('red', 'blue'))
     # 위치는 3*3으로 나누어진 영역을 top, center, bottom, left, right를 조합해서 지정
     
     # 한 화면에 여러개의 그래프 배치
     # mfrow=c(행, 열) 행중심
     # mfcol=c(행, 열) 열중심
     
     # 2*2 형태의 그래프 배치
     par(mfrow=c(2, 2)) # 2*2 화면 나눔
     attach(mtcars)
     plot(wt, mpg, main='차량무게 대비 연비 산점도')
     plot(wt, disp, main='차량무게 대비 연비 산점도')
     hist(wt, main='차량무게 히스토그램')
     boxplot(wt, main='차량무게 박스플롯')
     detach()
     
     
     # 1*3 형태의 그래프 배치
     attach(mtcars)
     par(mfrow=c(3, 1))
     hist(wt) # 차체 중량
     hist(mpg) # 연비
     hist(disp) # 배기량
     detach(mtcars)
     
     # 1*2 형태의 그래프 배치
     # layout : 영역의 갯수는 행렬을 이용
     # layout(matrix(영역번호), 너비, 높이)
     # layout.show : 영역을 미리 볼 수 있음
     attach(mtcars)
     layout(matrix(c(1, 1, 2, 3), 2, 2, byrow=T))
     hist(wt)
     hist(mpg)
     hist(disp)
     detach(mtcars)
     
     
     attach(mtcars)
     split.screen(c(2, 1)) # 스크린을 2행 1열로 나눔
     split.screen(screen=2, c(1, 2)) # 2행 1열 스크린을 1행 2열로 나눔
     screen(1) # 1, 2
     hist(wt)
     screen(3) # 2, 1
     hist(mpg)
     screen(4) # 2, 2
     hist(disp)
     detach(mtcars)
     close.screen(all=T) # 화면을 원래대로
     
     
     # 선형 그래프 - plot
     # 시간별 추세를 표시하는데 적합
     apple <- c(30, 90, 120, 160, 230)
     plot(apple, type='o', col='red', axes=F, ann=F)
     axis(1, at=1:5, lab=c('월', '화', '수', '목', '금'))
     axis(2, ylim=c(0, 250))
     title(main='요일별 사과 섭취량', col.main='purple', font.main=4)
     title(xlab='요일', col.lab='black')
     title(ylab='섭취량', col.lab='blue')
     
     # 막대 그래프
     # 여러가지 통계나 사물의 양을 막대 모양의 길이로 나타내어 알아보기 쉽도록 그린 그래프
     # 수량의 많고 적음이나 늘고 줄어드는 양, 크고 작음을 비교하거나 변화 상황의 일별, 월별, 연별 통계 등에 많이 이용 - 자료를 쉽게 비교
     apple <- c(30, 90, 120, 160, 230)
     peach <- c(20, 45, 50, 30, 25)
     berry <- c(10, 15, 15, 10, 5)
     
     fruits <- data.frame(apple, peach, berry)
     barplot(as.matrix(fruits), main='과일 섭취량', ylab='섭취량', xlab='과일', 
             col=rainbow(5), beside = T, ylim=c(0, 250))
     
     # 히스토그램
     # 각 데이터의 구간을 대표하는 대표값을 기준으로 나타낸 분포표를 그래프로 나타낸 것
     # 연속적인 데이터의 분포를 주로 표현하는데 사용
     stud <- c(0, 1, 2, 3, 4, 4, 5, 8, 23, 22, 0)
     score <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
     hist(score, main='성적 히스토그램', breaks = 10)
     
     # 원 그래프 - pie
     # 전체를 기준으로 한 부분의 상대적 크기를 표시
     # 각 항목의 합이 100%가 되어야 한다
     slices <- c(10, 12, 4, 16, 8)
     lbls <- c('미국', '영국', '호주', '독일', '프랑스')
     pie(slices, lbls, main='국가별 주류 소비량')
     
     # 상자 그림 - boxplot
     # 중앙값, 평균, 사분위수 등과 같은 주요 통계 측정치를 시각화
     # 변수의 주요 통계 속성을 검사하는데 유용한 시각적 보조 도구를 제공
     boxplot(apple, peach, berry, col=c('red', 'yellow', 'green'), 
             names=c('사과', '복숭아', '딸기'))
     attach(iris)
     boxplot(Sepal.Width, Petal.Width, names=c('꽂받침 너비', '꽃잎 너비'))
     detach(iris)