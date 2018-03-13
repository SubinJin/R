
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

# 학점계산 - 사분위수
# quantile() - 집단에서 측정된 수치의 특성을 표현
# 분위수 - 확률적으로 균등하게 영역을 나눠 계산한 수
y <- quantile(score,c(.8,.6,.4,.2))
y
y[[1]]
roster$grade[score >= y[1]] <- 'A' # 상위 80%에 속하는 사람들 : 0.74
roster$grade[score < y[1] & score >= y[2]] <- 'B' # 상위 79%~60%에 속하는 사람들 : 0.44
roster$grade[score < y[2] & score >= y[3]] <- 'C'
roster$grade[score < y[3] & score >= y[4]] <- 'D'
roster$grade[score < y[4]] <- 'F'
roster
# 이름과 성을 분리 : strsplit
strsplit(roster$Student,'') # 모든 글씨가 하나씩 분리되므로 실행X, sep=''
strsplit(roster$Student,' ') # 공백으로 분리 sep=' '
# apply(대상, 행/열, 함수) : 배열, 행렬에 함수를 행이나 열의 방향으로 적용 / 결과는 벡터, 행렬, 리스트로 출력(범용으로 사용)
sum(1~20) # 1 ~ 20까지의 합 : 벡터, 1차워배열
nums <- matrix(1:20, ncol=4) # 2차원배열
apply(nums,1,sum) # 행 단위로 sum적용
apply(nums,2,sum) # 열 단위로 sum적용
# sapply(대상, 함수) : 열 단위로 함수 적용(출력 : 벡터)
# lapply(대상, 함수) : 열 단위로 함수 적용(출력 : 리스트)
iris[1:4]
class(iris[1:4])
iris[,1:4]
class(iris[,1:4])
A <- apply(iris[,1:4], 1,mean) # 결과가 벡터(행)
A
B <- apply(iris[,1:4], 2,mean) # 결과가 벡터(열)
B
lapply(iris[,1:4], mean) # 결과는 리스트(열)
sapply(iris[,1:4], mean) # 결과는 벡터(열)
name <- c('a 1', 'b 2')
names <- strsplit(name, ' ')
names[[1]][1]
names[[1]][2]
apply(names,1,'[') # 오류발생
sapply(names,'[',1) # names에 있는 모든 원소에 대해 행단위로 원소추출 함수([) 적용 후 첫번째 원소 목록 출력

names <- strsplit(roster$Student, ' ')
lname <- sapply(names,'[',1)
lname
fname <- sapply(names,'[',2)
fname
# roster <- cbind(fname,lname)
roster <- cbind(fname, lname, roster[,-1]) # 기존 데이터프레임에서 첫번째 열을 제외한 뒤 이름과 성을 각각 열로 추가한다.
roster
roster <- roster[order(lname,fname),]
# 실행흐름 제어 : if, for, switch
# 반복문 - 자주 사용하지 않는다, 대신 apply함수를 주로 이용
for (i in 1:10){
  print(i)
  result <- i * 3
  print(result)
}
i <- 1
while(i<=10){
  print(i)
  i <- i+1
}
i <- 1
while(T){
  i <- i*3
  print(i)
  if(i > 99999) break
}
i <- 1
repeat{               # do-while 구문과 유사
  result <- i*3
  print(result)
  if(result > 999999) break
  i <- i+1
}
# 조건문 - if
grade <- '수'
if(is.character(grade)) {grade <- as.factor(grade)}
if(!is.factor(grade)) {
  grade <- as.factor(grade)
} else { 
  print('이미 factor 형으로 선언된 변수입니다.!!!')
}
# ifelse(조건, 문장1, 문장2)
i <- 1
ifelse ((i>10),'10보다 크다.','10보다 작거나 같다.')
x <- c(6:-4)
sqrt(x) # 경고 표시 - 음수는 제곱근 계산 불가!
sqrt(ifelse(x>=0,x,NA)) # 경고는 표시x
# switch
todayfeels <- c('sad','blue','happy','afraid')
for (i in todayfeels){
  print(
    switch(i, happy='행복', afraid='두려움', blue='우울', sad='슬픔')
  )
}
todayfeels <- c(1:4)
for (i in todayfeels){
  print(
    switch(i, '행복', '두려움', '우울', '슬픔')
  )
}