
# dataManage3
# 결측치 : 누락된 값, 비어있는 값, NA(Not Answer), 99999, nuknown
#         함수 적용 불가, 분석 결과 왜곡(제거 또는 대체 후 분석 실시)
df <- data.frame(gender <- c('남', '여', '남', '남', '여'),
                 score <- c(5, 3, 2, NA, 4))
# 결측치 확인 - is.na()
is.na(df)
# 결측치 빈도 확인
table(is.na(df))
df[3, 1] <- NA
table(is.na(df))
table(is.na(df$gender)) # 성별에서 결측치 측정
# 평균계산 - 결측치NA 포함 상태
mean(df$score) # NA로 출력
sum(df$score)
# 결측치 처리(제거) - na.rm=T
mean(df$score, na.rm=T)
sum(df$score, na.rm=T)
# 결측치 처리(제거) - na.omit()
odf <- na.omit(df)
odf # 결측치를 데이터 셋에서 제거
mean(odf$score)
sum(odf$score)

# MASS 라이브러리의 Cars93 데이터 집합에서 결측값이 모두 몇개인지 확인
library(MASS)
table(is.na(Cars93))
mean(Cars93$Weight, na.rm=T)

# 결측치 확인 - complete.cases
# 데이터 프레임의 각 행에 대해 결측치를 확인
# 행에 저장된 값이 모두 결측치가 아닌 경우에만 TRUE 반환
complete.cases(Cars93)
table(complete.cases(Cars93))
Cars93[!complete.cases(Cars93), ] # 결측치가 하나라도 있는 행

# is.na (값) vs complete.cases (행)
# 간단예제
iris_na <- iris
iris_na [c(10, 20, 25, 40, 32), 3] <- NA
iris_na [c(33, 100, 125), 1] <- NA
is.na(iris_na)
complete.cases(iris_na)
table(complete.cases(iris_na))
iris_na[!complete.cases(iris_na), ]

# 결측값 처리
# 결측값이 있는 행을 제거
# 평균값 또는 임의의 값으로 대체
# R에서는 DMwR 패키지를 이용해서 중앙값으로 대체
# 혹은 DMwR 패키지의 KNN 알고리즘을 이용해서 가중평균치로 대체

# 임의의 값으로 대체
# 0으로 대체
df
odf <- df
odf[is.na(odf$score)] <- 0
odf
# 평균값으로 대체
odf <- df
omean <- mean(odf$score, na.rm=T)
odf$score <- ifelse(is.na(odf$score), omean, odf$score)
odf

# DMwR 패키지 - 중앙값 대체
iris_na[1:4]
mapply(median, iris_na[1:4], na.rm=TRUE)
# 위에서 구한 중앙값을 NA가 위치한 곳에 대체 - 각 열별로 모두 지정해야 되서 불편
iris_na$Sepal.Length <- ifelse(is.na(iris_na$Sepal.Length), median, iris_na)
# NA가 있는 행을 일일이 찾아서 써야 된다는 치명적인 단점이 있음
install.packages('DMwR')
library(DMwR)
centralImputation(iris_na[1:4])[c(10, 20, 25, 40, 32, 100, 125,33), ]

# DMwR 패키지 - KNN 알고리즘 가중평균치 대체
knnImputation(iris_na[1:4])[c(10, 20, 25, 40, 32, 100, 125,33), ]

# 이상치 : 정상 기준에서 벗어난 값
# 논리적 판단 : 나이가 150을 넘으면, 점수가 100점을 넘으면 극단치
# 통계정 판단 : 평균으로부터 3표준편차 떨어진 값, 사분위 수에서 상/하단 경계를 벗어난 값

age <- c(10, 23, 33, 999, 121)
score <- c(50, 75, 88, 200, 150)
name <- c('a', 'b', 'c', 'd', 'e')
df2 <- data.frame(name, age, score)
df2
# 이상치 판단(논리적, 통계적) -> NA 대체 -> 결측치 처리
df2$age <- ifelse(df2$age > 100 | df2$age < 0, NA, df2$age) # 100 초과 0미만은 NA로
df2$score <- ifelse(df2$score > 100 | df2$score < 0, NA, df2$score)

df2 <- rbind(na.omit(df2), df2_na) # 결측치를 제거한 df2와 df2_na를 합침
df2
# KNN 알고리즘 이용해서 가중평균치로 대체
df2
df2_na <- knnImputation(df2)[!complete.cases(df2), ]
# Not sufficient complete cases for computing neighbors
# 둘 이상의 속성이 누락되어 가장 가까운 이웃을 계산할 수 없기 때문
df2 <- rbind(na.omit(df2), df2_na)
df2

# 결측 처리시 %n%를 사용
# 
library(ggplot2)
mpg # 98년 ~ 08년 동안 38개의 차종에 대한 연비 통계
mpgdrv <- mpg$drv
table(mpgdrv) # 이상치 여부 확인
mpgdrv <- ifelse(mpgdrv %in% c('f', 'r', '4'), mpgdrv, NA)
mpgdrv_na <- knnImputation(mpgdrv)[!complete.cases(mpgdrv), ]
mpgdrv <- rbind(na.omit(mpgdrv), mpgdrv_na)
mpgdrv
df2_na <- centralImputation(df2)[!complete.cases(df2), ]