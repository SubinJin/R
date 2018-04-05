
# 텍스트 마이닝 패키지 설치
install.package('tm')
library(tm)

# 텍스트 파일 읽기
inputText <- readLines('c:/Java/output2.txt')
inputText 

# 텍스트마이닝 작업을 위해 문서내용을 코퍼스corpus 형으로 변환
corpus <- Corpus(VectorSource(inputText))

# 문서 전처리 과정 수행
# 문장부호, 특정문자, 대소문자 변환작업 수행
docs <- tm_map(corpus, content_transformer(tolower)) # 소문자 변환
docs <- tm_map(docs, removeNumbers) # 숫자 제거
docs <- tm_map(docs, removePunctuation) # 문장 부호 제거
docs <- tm_map(docs, stripWhitespace) # 공백 제거
docs <- tm_map(docs, removeWords, c('New Jersey')) # 단어 제거

summary(docs) # 코퍼스 자료 요약정보 출력
inspect(docs) # 코퍼스에 저장된 본문 출력
inspect(docs[1:3]) # 코퍼스에 저장된 문장 1 ~ 3행 출력

strwrap(docs[1]) # 코퍼스에 저장된 문장 출력

# 전처리된 문서들을 행렬로 변환
dtm <- TermDocumentMatrix(docs)
dtm <- as.matrix(dtm)
freq <- sort(rowSums(dtm), decreasing=T)
freq[1:10]

barplot(freq[1:10]) # 출현빈도에 따라 그래프 출력
