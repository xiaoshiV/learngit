library(RJDBC)
#连接bxdw的函数，1为线下的jdbc，2为线上的jdbc，3为线下的odbc
connectbx<-function(i,jar_locate){ 
  if(i==1){ 
    dbdrv_DW <<- JDBC("org.postgresql.Driver", jar_locate)
    connDW <<- dbConnect(dbdrv_DW, "jdbc:postgresql://bi.baixing.com:15432/bxdw", "pguser", "Playwithdata!")
  }
  if(i==2){
    dbdrv_DW <<- JDBC("org.postgresql.Driver","/usr/local/bxdwenv/postgresql-default.jdbc4.jar")
    connDW <<- dbConnect(dbdrv_DW, "jdbc:postgresql://sha2dw01/bxdw", "pguser", "Playwithdata!")
  }
  if(i==3){ #如果用这个，下面的调用函数都要改掉，2了。
    connDW <<- odbcConnect('pgsql', 'pguser', 'Playwithdata!')
  }
  if(i==4){
    for(l in list.files('/usr/local/hive-default/lib/')){ .jaddClassPath(paste("/usr/local/hive-default/lib/",l,sep=""))}
    for(l in list.files('/usr/local/hive-default/lib/')){ .jaddClassPath(paste("/usr/local/hive-default/lib/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/common/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/common/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/common/lib/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/common/lib/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/common/sources/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/common/sources/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/hdfs/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/hdfs/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/hdfs/lib/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/hdfs/lib/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/hdfs/sources/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/hdfs/sources/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/httpfs/tomcat//lib')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/httpfs/tomcat//lib",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/mapreduce/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/mapreduce/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/mapreduce/lib/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/mapreduce/lib/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/tools/lib/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/tools/lib/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/tools/sources/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/tools/sources/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/yarn/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/yarn/",l,sep=""))}
    for(l in list.files('/usr/local/hadoop-default/share/hadoop/yarn/lib/')){ .jaddClassPath(paste("/usr/local/hadoop-default/share/hadoop/yarn/lib/",l,sep=""))}      
    options( java.parameters = "-Xmx8g" )
    drv <<- JDBC("org.apache.hive.jdbc.HiveDriver", "/usr/local/hive-default/lib/hive-jdbc-0.13.1.jar")
    conn <<- dbConnect(drv, "jdbc:hive2://sha2hdpn02:26162", "hiveuser", "resuevih_ResuEVIH")   
  }
}
jar_locate="C:\\Program Files\\R\\R-3.1.1\\etc\\postgresql-9.3-1102.jdbc4.jar"
connectbx(2)
connectbx(4)


mysendmail<-function(wd,from = "bxgehongshan@163.com", to = c("gehongshan@baixing.net"),subject,msg="Hello",files=array()){
  library(mailR)
  if(is.na(files)){
    attach.files<-NULL
  }else{
    attach.files<-paste(wd,files,sep="/")
  }
  send.mail(from = from ,
            to = to,
            subject =subject,
            body = msg,
            smtp = list(host.name = "smtp.163.com", port = 465, user.name = "bxgehongshan@163.com", passwd = "gehongshan", ssl = TRUE),
            authenticate = TRUE,
            send = TRUE,
            attach.files=attach.files,
            encoding="utf-8")
}