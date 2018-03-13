# attach : 특정 데이터프레임 명을 검색경로에 추가
# detach : 특정 데이터프레임 명을 검색경로에 제거
attach(patientData)
patientID
age
diabetes
status
detach(patientData)

# with(객체명, {속성명})
with(patientData, {age})
with(patientData, {print(age) print(status)})