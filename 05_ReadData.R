# readData.R
# 데이터를 외부로부터 가져오는 방법
# 1. 키보드로 입력 - edit(), fix()
# 작은 데이터 집합을 사용해야하는 경우 유용
smalldata <- data.frame(age=numeric(0), weight=numeric(0.0))
smalldata <- edit(smalldata)

# R의 데이터 타입 : numeric, character, logical
# 예제 - Table 4.1 예제
managerdata <- data.frame(manager=numeric(0), date=character(0), country=character(0), gender=character(0), age=numeric(0), q1=numeric(0), q2=numeric(0), q3=numeric(0), q4=numeric(0), q5=numeric(0))
mangerdata <- edit(managerdata)


txtdata <- '
age weight
1 0.7
2 1.3
3 2.1
'
txtdata

smalldata2 <- read.table(header = T, text=txtdata)
smalldata2

manager2 <- '
manager date country
1 10/24/14 US
2 10/28/14 US
3 10/01/14 UK
'
manager2

managerdata <- read.table(header = T, text=manager2)
managerdata


# read.table(파일명, 옵션)
sales <- read.table('C:/Bigdata/R3/sales.txt',sep=',',header=F)
# 파일로 읽어들이는 데이터의 자료유형 설정 - colClasses
# 읽어들이는 데이터의 유형과 정의한 자료유형은 일치해야 ㅎ
sales <- read.table('C:/Bigdata/R3/sales.txt',sep=',',header=T, 
                    colClasses=c('character','numeric','numeric'))
str(sales)
sales
rm(sales)

?read.table

# 두 번째 예제
SummerMedalists <- read.table('C:/Bigdata/R3/SummerMedalists.txt',sep='\t',header=T)
str(SummerMedalists)
SummerMedalists
rm(SummerMedalists)

# 세 번째 예제(stores)
stores = read.table('C:/Bigdata/R3/stores.txt',sep=',',header=T)
str(stores)
stores

# 네 번째 예제(stations)
stations = read.table('C:/Bigdata/R3/stations.csv',sep=',',header=T)
str(stations)
stations


?read.csv
?read.csv2

stations = read.csv('C:/Bigdata/R3/stations.csv', header=F)
stations = read.csv('C:/Bigdata/R3/stations.csv', header=F, na.strings = '')
stations
rm(stations)


install.packages('readxl')
library('readxl')
medal <- read_excel('c:/Bigdata/R3/SummerMedalists.xlsx',sheet=1)
str(medal)
medal

# 또 다른 패키지(xlsx) : 속도가 느려서 비추!!
Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_162')
install.packages('rJava')
install.packages('xlsx')
library('xlsx')
medal2 <- read.xlsx('c:/Bigdata/R3/SummerMedalists.xlsx',sheetIndex=1)
medal2


install.packages('XML')
library('XML')
library('methods')
xmldata <- xmlParse('c:/Bigdata/R3/emp.xml')
empdata <- xmlToDataFrame('c:/Bigdata/R3/emp.xml')
xmldata
empdata


install.packages('jsonlite')
library('jsonlite')
install.packages('httr')
library('httr')

# jsondata <- fromJSON('c:/Bigdata/R3/primer-dataset.json')
jsondata <- fromJSON('https://api.github.com/users/hadley/repos')
str(jsondata)
jsondata


zip <- read.table('c:/Bigdata/R3/서울특별시-2017.10.csv',sep=',',stringsAsFactors = F,header = T, fill=T)
head(zip)
str(zip)

zip2 <- read.csv('c:/Bigdata/R3/서울특별시-2017.10.csv',sep=',',stringsAsFactors = F,header = T)
head(zip2)
str(zip2)

install.packages('data.table')
library('data.table')
?fread

zip3 <- fread('c:/Bigdata/R3/서울특별시-2017.10.csv',sep=',',stringsAsFactors = F,header = T)
head(zip3)
names(jsondata) # JSON 데이터의 키를 출력