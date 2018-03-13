# MySQL
install.packages('RMySQL')
library('RMySQL')

mysqlconn <- dbConnect(MySQL(), user='mspapa0225', password='Abcdef_12', dbname='mspapa0225', host='192.168.241.129')
dbListTables(mysqlconn) # 테이블목록 출력

empdata <- dbSendQuery(mysqlconn, 'select*from employees')
emp <- fetch(empdata)
str(emp)

dbDisconnect(mysqlconn)

# Oracle
Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_162')
install.packages('DBI',dep=T)
install.packages('RJDBC',dep=T)
library('DBI')
library('RJDBC')
library('rJava')

drv <- JDBC('oracle.jdbc.OracleDriver',classPath = 'C:/Bigdata/Connector/ojdbc7.jar')
oraconn <- dbConnect(drv, 'jdbc:oracle:thin:@192.168.241.129:1521:xe','hr','hr')
emp <- dbGetQuery(oraconn, 'select * from EMPLOYEES')
emp

dbDisconnect(oraconn)