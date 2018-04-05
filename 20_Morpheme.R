# 형태소분석
# github.com/haven-jeon/KoNLP/blob/master/etcs/KoNLP-API.md
install.packages('rJava')
install.packages('memoise')
install.packages('KoNLP')

library(KoNLP)
library(dplyr)
library(stringr)

Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_152')

# 형태소 분석을 위한 참고사전 필요
# 분석할 문장에 포함된 단어들이 사전에 알맞는 형태로 정의되어야 저오학한 분석 가능
# KoNLP에는 세종 사전이 들어 있음
useSejongDic()


# 형태소 분리 : 명사 추출
sentence <- "분석할 문장에 포함된 단어들이 사전에 알맞는 형태(품사)로 정의되어야 정확한 분석 가능"
extractNoun(sentence)

# SimplePos09 : 상위 9개의 품사로 분류
# SimplePos22 : 상위 22개의 품사로 분류
# MorphAnalyzer : 가장 상세하게 품사를 분류
SimplePos09(sentence)
SimplePos22(sentence)
MorphAnalyzer(sentence)


# 트윗글 읽어오기
tweets <- readLines('C:/Java/article_10.txt', encoding='UTF-8')

head(tweets, 3)
class(tweets)

# 명사추출 : extractNoun
docs <- str_replace_all(tweets, "\\W", "")
nouns <- extractNoun(docs)
nouns
# 추출된 명사를 기반으로 워드카운트
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactor=F)
df_word <- rename(df_word, word=Var1, freq=Freq)
df_word < filter(df_word, nchar(word) >=2)

top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top20

install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RcolorBrewer")

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

pal <- brewer.pal(8, "Dark2") # Dark2 색상 중 8개 색추출
wordcloud(word = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 2, # 최소 단어 빈도
          max.words = 250, # 표현 단어수
          random.order = F, # 고빈도 중앙 배치 여부
          rot.per = .1, # 회전 단어 비율
          scale = c(4, 0.3), # 빈도별 확대 비율
          colors = pal)# 표현 색상

# 불용어 처리(공백, 특수문자 등)
docs <- str_replace_all(tweets, "\\[", "")
docs <- str_replace_all(tweets, "\\[0-9]", "")
docs <- str_replace_all(tweets, "\\[a-zA-Z]", "")
docs <- str_replace_all(tweets, "\\[ㅜ|ㅠ]", "")
docs <- str_replace_all(tweets, "\\[~!@#$%^&*()]", "")

word
