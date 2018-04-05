
install.packages('twitteR')
install.packages('ROAuth')
install.packages('plyr')
install.packages('stringr')

# 패키지 불러오기
library(twitteR)
library(ROAuth)
library(plyr)
library(stringr)

# 트위터 API를 이용해서 삼성, 애플에 대한 트윗 수집
load("C:/Java/apple.RData")
load("C:/Java/samsung.RData")

# 총 트윗 수 출력
length(apple.tweets)
apple.tweets[1:5]

tweet<-apple.tweets[[1]]
tweet$getScreenName() # 작성자
tweet$getText() # 트윗(본문)

apple.text<-lapply(apple.tweets,function(t){t$getText()})
head(apple.text,3)

# 감성분석을 위한 긍정/부정 사전을 불러옴
pos.word=scan("c:/Java/positive-words.txt",what="character",comment.char=";")
neg.word=scan("c:/Java/negative-words.txt",what="character",comment.char=";")

pos.words<-c(pos.word,"upgrade")
neg.words<-c(neg.word,"wait","waiting")


score.sentiment <- function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  scores <- laply(sentences, function(sentence, pos.words, neg.words){
    sentence <- gsub('[[:punct:]]', "", sentence)
    sentence <- gsub('[[:cntrl:]]', "", sentence)
    sentence <- gsub('\\d+', "", sentence)
    # 소문자로 변환 후 문장을 단어로 분리
    sentence <- tolower(sentence)
    word.list <- str_split(sentence, '\\s+')
    words <- unlist(word.list)
    # 분리된 단어와 긍정/부정 단어 간 비교
    pos.matches <- match(words, pos.words)
    neg.matches <- match(words, neg.words)
    # 긍정일치, 부정일치 계산
    pos.matches <- !is.na(pos.matches)
    neg.matches <- !is.na(neg.matches)
    # 점수 계산 = 긍정 일치수 - 부정 일치수
    score <- sum(pos.matches) - sum(neg.matches)
    return(score)
  }, pos.words, neg.words, .progress=.progress)
  scores.df <- data.frame(score=scores, text=sentences)
  return(scores.df)
}
# 애플에 대한 트윗을 기반으로 감성분석 후 점수 출력
apple.scores=score.sentiment(apple.text,pos.words,neg.words,.progress='text')
# 감성분석 결과를 그래프로 출력
# 클수록 긍정의 의미
hist(apple.scores$score)
samsung.scores=score.sentiment(samsung.text, post.words, neg.words, .progress='text')

# 삼성
samsung.text<-lapply(samsung.tweets,function(t){t$getText()})
head(samsung.text,3)
# 삼성에 대한 트윗을 기반으로 감성분석 후 점수 출력
samsung.scores=score.sentiment(samsung.text,pos.words,neg.words,.progress='text')
hist(samsung.scores$score)