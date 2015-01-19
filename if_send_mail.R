
  source("/home/gehongshan/fun1.R")
t = Sys.time()
ifweekend = format(t,format = "%a")
if(ifweekend == "Sat"||ifweekend=="Sun") { print("weekend")
}else{
temp <- format(Sys.time(),format = "%Y-%m-%d")
temp <- as.Date(temp)
temp<-temp-1
stringformat<-format(temp,format = "%Y%m%d")
a<-dbGetQuery(connDW,paste("select time from dds.fact_call_info 
                          where team = '微创' and julian_date ='",stringformat,"'",sep=""))
if (is.null(a)||nrow(a)==0) {
  print("send mail") 
  mysendmail(wd=na,subject="dds.fact_call_info表中没有昨天微创的数据",file=NA,to=c("gehongshan@baixing.net","chenxuyuan@baixing.com","wangwendi@baixing.net"))
  
}else{ 
  print("ok")
}
}