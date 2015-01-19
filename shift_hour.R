shift_hour<-function(t){
if (substr(t,9,10)=="00"){
    temp <- format(Sys.time(),format = "%Y-%m-%d")
    temp <- as.Date(temp)
    temp<-temp-1
    temp<-format(temp,format = "%Y%m%d")
    t<-paste(temp,"23",sep="")
}else{
    t<-as.numeric(t)
    t<-t-1
    t<-as.character(t)
}
 return(t)
}
