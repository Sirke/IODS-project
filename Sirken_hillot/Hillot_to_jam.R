cashflow<-read.csv(file="Sirkenhillot.csv",header=TRUE,sep=";")
columns_in<-c("Pvm","Määrä")
money<-select(cashflow,columns_in)
money<-rename(money,amount=Määrä)
money<-rename(money,date=Pvm)
money$date <- as.Date(money$date, "%d.%m.%Y")
money<-filter(money,amount<0)
money$amount<-abs(money$amount)




library(zoo)
plot(amount~date,money, xaxt="n",type = "l")
axis(1, money$date, format(money$date, "%b %d"), cex.axis = .7)

require(ggplot2)
ggplot(data=money,aes(date, amount))+geom_line()
+scale_x_date(format = "%b-%Y") + xlab("") + ylab("Amounts of money used")

write.csv(money,"Sirkesjam.csv",row.names = F)
