# 팩터 - 벡터 자료구조에 추가정보가 더해진 것
# 카테고리 자료형을 만들어 데이터에 의미를 부여하고자 할 때 사용
a <- 1:3 # 1, 2, 3
a
factor(a, levels=c(1, 3, 5))
factor(a, levels=c(1, 3, 5), labels = c('일', '삼', '오'))

# 설문지 답변을 factor로 정의
# 1 : 아주 안좋음, 2 : 나쁘지 않음, 3 : 보통, 4 : 그럭저럭 좋음, 5 : 아주 좋음
mgr1_q <- c(5, 4, 5, 5, 5)
factor(mgr1_q, levels=1:5, 
       labels=c('아주 안좋음', '나쁘지 않음', '보통', '그럭저럭 좋음', '아주 좋음')
)

mgr1_q <- c(5, 4, 5, 5, 5)
levels_q <- c(1, 2, 3, 4, 5)
labels_q <- c('아주 안좋음', '나쁘지 않음', '보통', '그럭저럭 좋음', '아주 좋음')
factor(mgr1_q, levels=levels_q, labels=labels_q)