source("/home/gehongshan/fun1.R")
a<-dbGetQuery(connDW,"select
origin.user_id,
origin.cash_rev,
              origin.churn,
              origin.follow,
              team.team,
              call.call_date,
              call.call_time,
              cash.deal_rev,
              remark.remark
              from
              pgtemp.upload_xiaoyanzi_keyuser origin
              left join
              (
              select
              t1.user_id,
              t2.groupname as team
              from
              (
              select
              a.user_id,
              sales_user_id,
              julian_date
              from
              dds.fact_customer_history a
              left join
              (
              select
              user_id,
              to_date(created_date,'yyyymmdd')+1 as created_date
              from
              pgtemp.upload_xiaoyanzi_keyuser) b on a.user_id = b.user_id
              where 
              a.julian_date = to_char(b.created_date,'yyyymmdd')
              ) as t1
              left join 
              (
              select
              user_id,
              groupname
              from
              dds.dim_customer_sales
              ) as t2 on t1.sales_user_id = t2.user_id 
              
              ) team on origin.user_id=team.user_id
              left join
              (select
              b.user_id,
              julian_date as call_date,
              sum(length) as call_time
              from 
              pgtemp.xiaoyanzi_call_info a
              left join pgtemp.upload_xiaoyanzi_keyuser b on a.user_id = b.user_id
              where 
              a.julian_date >=b.created_date
              group by
              b.user_id,
              julian_date) call on origin.user_id = call.user_id
              left join
              (
              select
              b.user_id,
              sum(total_money) as deal_rev
              from
              dds.vw_fact_order a
              left join pgtemp.upload_xiaoyanzi_keyuser b on a.user_id = b.user_id
              where 
              a.julian_pay_date >=b.created_date
              group by
              b.user_id
              ) cash on origin.user_id = cash.user_id
              left join
              (
              select
              t1.user_id,
              t1.remark
              from
              (select
              b.user_id,
              a.remark,
              to_char(a.time_contact,'yyyymmdd')as call_date
              from pgtemp.crm_fuwuxiaoji a
              left join
              pgtemp.userid_bianhao b  on a.id_kehu = cast(b.crm_id as varchar)) t1
              left join
              pgtemp.upload_xiaoyanzi_keyuser t2 on cast(t1.user_id as bigint) = t2.user_id
              where
              t1.call_date >= t2.created_date
              ) remark on origin.user_id=cast(remark.user_id as bigint)")
write.csv(a,file="/home/gehongshan/to_send/send.csv",append=FALSE)
mysendmail(wd="/home/gehongshan/to_send",subject="大客户流失数据",file="send.csv",to=c("gehongshan@baixing.net","mengsufang@baixing.net"))