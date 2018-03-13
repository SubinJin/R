
# as.numeric() : is.numeric()
# as.character() : is.character()
# as.logical() : is.
# 날짜를 문자로 변환 - as.Character()
strDate <- as.character(edate)

# 데이터 정렬 - order()
leadership[order(leadership$age), ]
leadership[order(leadership$gender, leadershop$age), ]
leadership[order(leadership$gender, -leadershop$age), ]

# 데이터 병합 - merge(), rbind()
# 데이터가 여러 위치에 존재한다면 이것을 결합해보자

# 열 추가하기 - 수평적 결합
# merge : 공통의 key가 존재할 때
merge(dfA, dfB, by='ID')
merge(dfA, dfB, by=c('ID', 'country'))

id <- c(1:4)
fname <- c('park', 'kim', 'jeong', 'song')
pinfo1 <- data.frame(id, fname)

id <- c(5:7)
fname <- c('lim', 'yeon', 'park')
pinfo2 <- data.frame(id, fname)

id <- c(1, 2)
fname <- c('jin', 'son')
pinfo3 <- data.frame(id, fname)

merge(pinfo1, pinfo2, by='id') # inner join
merge(pinfo1, pinfo2, by='id', all=T) # outer join
merge(pinfo1, pinfo2, by='id', all.x=T) # left outer join
merge(pinfo1, pinfo2, by='id', all.y=T) # right outer join

merge(pinfo1, pinfo3, by='id') # 병합불가
merge(pinfo2, pinfo3, by='id')

# cbind, rbind : 공통의 key가 존재하지 않을 때

# 열 추가 : cbind(dfA, dfB)
cbind(pinfo1, pinfo3)
cbind(pinfo2, pinfo3)

# 행 추가 : rbind()
rbind(pinfo1, pinfo3)
rbind(pinfo2, pinfo3)

# 데이터 부분집합 만들기
# df[행, 열] 표기로 원소에 접근 가능
newdata <- leadership[, c(6:10)] # 인덱스로 추출
myvars <- c('q1', 'q2', 'q3', 'q4', 'q5')
newdata <- leadership[myvars] # 열이름으로 추출
newdata

# 문자열 이어 붙이기 : paste
myvars <- paste('q', 1:5, sep='') # q1, q2, q3...
newdata <- leadership[myvars]

paste('hello', 'world', '!!')
paste('hello', 'world', '!!', sep='-')
paste('hello', 'world', '!!', sep='')

# 변수 제외하기 : !, -, NULL
myvars <- names(leadership) %in% c('q3', 'q4')
# %in% : R의 특수 연산자 - 특정값 포함 여부 검사
newdata <- leadership[myvars] # TRUE인 열만 출력
newdata <- leadership[!myvars]

newdata <- leadership[c(8, 9)] # 8, 9열 출력
newdata <- leadership[c(-8, -9)]

leadership$q3 <- leadership$q4 <- NULL
leadership

# 관측치를 검색 후 선택
newdata <- leadership[1:3, ] # 1, 2, 3행 출력
newdata
leadership[leadership$gender == 'M' & leadership$age > 30, ] # 설병=남자, 나이>30

# 날짜 기간으로 검색
# 먼저, 문자형식을 날짜형식으로 변환
leadership$date <- as.Date(leadership$date, '%m/%d/%y')
# 검색기간도 날짜 형식으로 지정
startdate <- as.Date('2014-01-01')
enddate <- as.Date('2014-05-31')
# which 함수 사용
which(leadership$date >= startdate & leadership$date <= enddate)

# 변속기am가 자동, 실린더cyl가 4인 자동차의 연비mpg 출력
cardata <- mtcars[which(mtcars$am == 0 & mtcars$cyl == 4), ] # 전체
cardata <- mtcars[which(mtcars$am == 0 & mtcars$cyl == 4), 'mpg'] # 연비만

attach(mtcars)
which(mtcars$am == 0 & mtcars$cyl == 4)
cardata <- mtcars[which(mtcars$am == 0 & mtcars$cyl == 4), 'mpg']
detach(mtcars)

# 위 사례들보다 쉽게 부분 데이터 추출 - subset()
newdata <- subset(leadership, age > 35 | age < 24, select = c(q1, q2))
# 성별이 남M이고, 나이가 25 이상인 매니저의 성별, 나이
manager <- subset(leadership, age > 25 & gender == 'M', 
                  select = gender:q4) # gender부터 q4까지
# 무작위 표본 - sample : 비복원 / 복원 추출
# sample(data, 갯수, 복원/비복원 여부)
sample(x=1:10) # 비복원 추출
sample(x=1:10, replace=T) # 복원 추출
data <- c(1:10)
sample(x=data, 3)
sample(x=data, 3, replace=T)
mysample = leadership[sample(1:5, 3, replace=T), ]
mysample = leadership[sample(1:5, 3), ]

# 행/열의 수 출력 : nrow(), ncol()
nrow(leadership)
ncol(leadership)
mysmaple = leadership[sample(1:5, 3), ]

# 데이터를 SQL처럼 사용! - sqldf
# sqldf는 SQL명령이 실행되면 자동으로 스키마 생성 후 데이터를 테이블에 불러온 후
install.packages('sqldf')
library(sqldf)
iris # 붓꽃 3가지 종료에 대해 꽂받침, 꽃잎길이 정리
sqldf('select * from iris')

# 붗꽃 종을 출력 - 중복 배제
sqldf('select * from iris group by Species')
sqldf('select distinct Species from iris')
unique(iris$Species)
iris[!duplicated(iris$Species), ]
distinct(iris$Species) # dplyr 패키지 필요!
sql <- 'select count(Species) from iris where "Petal.Width" >0.5'
# 점이 들어 있으면 큰 따옴표로 묶자(이유는 모르지만 따옴표 없으면 오류남)
sqldf(sql)

# 구글에서 제공하는 데이터집합 - fruits
install.packages('googleVis')
library(googleVis)
fruits

# 학생 성적 데이터에 대해 학점을 부여
# 3과ㅁ목 점수가 일정하지 않은 -평균, 편차 구학 ㅣ어려움
# 학점을 구하려면 백분위를 결정
# 이름으로 정렬하기 어려움 - 성과 이름이 붙어있기 때문에 → 성과 이름 분리

# 수학함수
data<- c(-3, 3, 9)
abs(data) # 절대값
sqrt(data) # square-root
ceiling(data) # 올림
floor(data) # 내림
round(data) # 반올림
trunc(data) # 절삭
signif(data) # 유효숫자
sort(data) # 정렬
rev(data) # 역순
rank(data) # 순위
cumsum(data) # 누적합
cumprod(data) # 누적곱
cummax(data) # 누적 최대대값
cummin(data) # 누적 최소값

# 통계함수
sum(data)
prod(data)
max(data) # 최대
min(data) # 최소
diff(data) # 차분
which.max(data)
which.min(data) # 최소값의 index
range(data) # 범위

mean(data) # 평균
median(data) #중간
sd(data) # 표편
var(data) # 분산
mad(data) # 중위

# 확률함수 : runif() 0 ~ 1 사이의 균등분포난수 생성
# set.seed(nnn) 난수생성 seed 설정
runif(10)

# 문자함수 : nrow, ncol
ch <- c('ab', 'xyz', 'abc123')
nchar(ch) # 문자수를 센다
ch <- 'abc123xyz987'
substr(ch, 4, 9)

grep('xyz', ch, fixed=T) # 지정한 패턴에 의해 문자검색
x <- c('abc', '123', 'xyz', '987')
grep('xyz', x, fixed=T)

sub() # 패턴에 의해 지정한 문자를 검색하고 문자 치환
sub('\\s', '.', 'Hello, World!') # 공백을 .으로 바꿔줌

strsplit() # 문자에서 특정 요소를 분리
c <- strsplit('abc123', '')
paste() # 구분자로 문자열을 분리한 후 결합
paste('x', 1:3, sep='')
paste('x', 1:3, sep='M')
paste('오늘은', date())

toupper(ch) # 대문자 변환
tolower(ch) # 소문자 변환

# 성적처리
# 성적 처리 지표 : ABCDF
options(digits=2) # 소수점 2자리
Student <- c()
Math <- c()
Science <- c()
English <- c()
roster <- data.frame(Student, Math, Science, English, stingsAsFactors=F)
# 성적 데이터를 표준화 시킴 : scale
# 많은 분류 알고리즘에 유용하게 사용 : KNN, SVM, 신경망
# 변수값을 적당한 수준으로 조정 : 0 ~ 1, -1 ~ 1
# 조정된 값을 평균과 표준편차로 다시 계산
iris[1:4]
scale(iris[1:4])

# 성적 데이터 표준화화
newdata <- scale(roster[, 2:4])

# 평균점수 구하기
mean(newdata) # 결과가 제대로 안나옴
# apply 함수 이용
# 특정 연산을 손쉽게 처리하게 해주는 함수
score <- apply(newdata, 1, mean) # 행단위 연산
apply(iris[1:4], 1, mean)
apply(iris[1:4], 2, mean) # 열단위 계산

apply(iris[1:4], 1, function(x){x +100})

apply(Fruits[4:6], 1, mean)
apply(Fruits[4:6], 2, mean)
# 구해진 평균점수를 roster 테이블에 열로 추가
roster <- cbind(roster, score)