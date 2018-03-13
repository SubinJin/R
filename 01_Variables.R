
patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c('Type1', 'Type2', 'Type1', 'Type1')
status <- c('poor', 'improved', 'excellent', 'poor')
patientData <- data.frame(patientID, age, diabetes, status)
prtientdata # 환자 정보 출력
str(patientdata) # 데이터 객체의 구조를 출력
patientData[1:2] # 1, 2 속성 출력
patientData[c('diabetes', 'status')] # 속성명으로 출력
patientData$age # 객체명에 $를 사용해서 속성명을 다룰 수 있음
# 위 사례처럼 모든 변수앞에 patientData$를 이용해서 특정속성을 출력하는 것은 불편
# attach(), detach(), with() 사용해서 해결 가능