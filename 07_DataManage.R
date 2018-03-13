
# 기초 데이터 관리

# 리더십에 관한 조사결과
# 성별에 따라 매니저의 리더십이 관계있나?
# 국적도 중요한 요인인가?
# 질문에 대한 평점은 1~5까지 설정

manager <- c(1,2,3,4,5)
date <- c('10/24/14','10/28/14','10/01/14','10/12/14','05/01/14')
country <- c('US','US','UK','UK','UK')
gender <- c('M','F','F','M','F')
age <- c(32,45,25,39,99)
q1 <- c(5,3,3,3,2)
q2 <- c(4,5,5,3,2)
q3 <- c(5,2,5,4,1)
q4 <- c(5,5,5,NA,2)
q5 <- c(5,5,2,NA,1)

leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors = F)
leadership


# 데이터 프레임에 새로운 열을 추가하려면 $연산자 사용하거나 transform() 함수를 이용한다.

mydata <- data.frame(x1 = c(2,2,6,4), x2 = c(3,4,2,8))
mydata

# 잘못된 사용의 예
sumx <- x1+x2
meanx <- (x1+x2)/2

# 올바른 사용의 예
sumx <- mydata$x1+mydata$x2      # 총합
meanx <- (mydata$x1+mydata$x2)/2 # 평균
sumx
meanx

# 데이터 프레임에 새로운 속성 추가 : `$` 사용
mydata$sumx <- mydata$x1+mydata$x2
mydata$meanx <- (mydata$x1+mydata$x2)/2
mydata # 하지만 이 방법은 컬럼이 많아질 경우 모두 다 써주어야 하기 때문에 비추!!


# attach / detach 사용
rm(mydata)
mydata <- data.frame(x1 = c(2,2,6,4), x2 = c(3,4,2,8))
attach(mydata)
mydata$sumx <- x1+x2
mydata$meanx <- (x1+x2)/2
detach(mydata)
mydata

# transform() 사용
rm(mydata)
mydata <- data.frame(x1 = c(2,2,6,4), x2 = c(3,4,2,8))
mydata <- transform(mydata, sumx = x1+x2, meanx = (x1+x2)/2)
mydata


# 기존의 변수나 값을 기준으로 새로운 변수값을 생성
# 연속값을 가지는 변수를 3개의 카테고리로 나눔
# 잘못 작성된 값을 바른 값으로 대체
# 조건에 따라 통과 / 탈락 변수 생성

leadership$age_category[leadership$age > 75] <- '노년'
leadership$age_category[leadership$age > 50 && leadership$age > 64] <- '중년'
leadership

leadership$age_cate[leadership%age == 99] <- '백수'
leadership$age_cate[leadership%age < 99] <- '졸수'
leadership$age_cate[leadership%age < 89] <- '산수'
leadership$age_cate[leadership%age < 79] <- '고희'
leadership$age_cate[leadership%age < 69] <- '이순'
leadership$age_cate[leadership%age < 59] <- '지천명'
leadership$age_cate[leadership%age < 49] <- '불혹'

# within을 이요해서 간결하게 작성
leadership <- within(leadership, {
  age_cate[age==99] <- '백수'
  age_cate[age<99] <- '졸수'
  age_cate[age<90] <- '산수'
  age_cate[age<80] <- '고희'
  age_cate[age<70] <- '이순'
  age_cate[age<60] <- '지천명'
  age_cate[age<50] <- '불혹'
})


fix(leadership) # 데이터 편집기를 이용
leadership

names(leadership)
names(leadership)[2] <- 'newDate'
names(leadsership)[6:10] <- c('q1', 'q2', 'q3', 'q4', 'q5')

# plyr 패키지를 이용해서 이름을 바꾸자
library('plyr')
leadership <- rename(leadership, 
                     c(manager='managerID', date='examDate', country='nation'))


# 결측값(누락된 값) 처리
# 누락, 오류, 부적절한 데이터를 보완 - NA
# is.na()는 누락값 여부 확인

x <- c(1, 2, 3, NA)
is.na(x) # F F F T
is.na(leadership[,6:10])

# 누락값은 비교 불가능 -> 비교연산자 사용불가
# 분석에서 누락값은 제외하는 것이 좋음

y <- x[1] + x[2] + x[3] + x[4]
# NA가 포함된 벡터에 산술연산을 하면?
z <- sum(x)
# na.rm=T를 이용해서 누락값 제외
z <- sum(x, na.rm=T)
# na.omit을 이용해서 NA가 있는 관측치를 제거
na.omit(leadership)
leadership


# Sys.Date(), Sys.time() : 현재 날짜/시간 출력
Sys.date() # 년월일
Sys.time() # 날짜, 시간
date() # 날짜, 시간, 요일

# 날짜 데이터를 입력할 때는 보통 문자형식을 사용
# 경우에 따라 날짜로 검색하거나 계산해야 할 필요가 있음
# 따라서, 문자형식을 날짜 형식으로 변환해야 함
# as.Date() : 기본 형식은 yyyy-mm-dd
mydate <- c('2007-10-15', '2018-03-03')
class(mydate)
mydates <- as.Date(mydate)
class(mydates)

fmt <- '%m / %d  / %y' # %y는 두자리 년도
leadership$date <- as.Date(leadership$date, fmt)
leadership

# 날짜 변환 형식지정자
today <- Sys.Date()
format(today, format='%m %b %B %Y %y')
format(today, format='%A %a %d')

sdate <- as.Date('1992-07-05')
edate <- as.Date('2018-03-01')
mydays <- edate - sdate
mydays

difftime(edate, sdate) # 지정 안하면 day로 카운트
difftime(edate, sdate, units='weeks') # hours, days, mins, secs, auto 가능