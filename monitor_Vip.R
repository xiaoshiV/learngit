source("/home/gehongshan/fun1.R")
b<-dbGetQuery(connDW,"select * from pgtemp.recruit_vip2")
              
              
  write.csv(b,file="/home/gehongshan/to_send/send1.csv",append=FALSE)
  mysendmail(wd="/home/gehongshan/to_send",subject="招聘VIP监控",file="send1.csv",to=c("gehongshan@baixing.net","mengsufang@baixing.net"))
