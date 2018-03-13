# list : 하나의 이름 아래 다양한 객체들을 모아놓은 것
# 키, 값 형태로 데이터를 담아두는 연관 배열의 일종
# list(이름1=객체1, 이름2=객체2, 이름3=객체3,...)
sj1 <- list(name='수지', kor=99, eng=98, mat=99) # 단일값 list
sj1
sj[1]
sj[[1]]
sj['name']
sj[['name']]
sja1 <- list(name='수지', kem=c(99, 98, 97)) # 벡터를 list의 원소로 구성
sja1
mixed <= list(a=sj1, b=sja1) # list를 list의 원소로 구성
mixed

# sample R scripts 3
mtcars # 자동차 관련 데이터 집합
help(mtcars)
summary(mtcars$mpg) # mg에 대한 기본통계정보 출력
plot(mtcars$mpg, mtcars$disp) # 연료소비율과 배기량의 관계
plot(mtcars$mpg, mtcars$wt)

# attach, detach
attach(mtcars)
mpg
disp
wt
detach(mtcars)
plot(mpg, disp)
plot(mpg, wt)

attatch(mtcars)
plot(mpg, disp)
plot(mpg, wt)
detach(mtcars)

# with
with(mtcars, {mpg})
with(mtcars, {disp})
with(mtcars, {wt})
plot(mpg, disp)
plot(mpg, wt)

with(mtcars, {
  plot(mpg, disp)
  plot(mpg, wt)
}
)