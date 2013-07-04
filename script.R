#!/usr/bin/Rscript --vanilla
#TODO usage #HASGTAG YYYY-MM-DD YYYYMM-DD

library(twitteR)
library(ggplot2)

load("cred")
registerTwitterOAuth(cred)

tweets <- list()
dates <- paste("2013-07-",01:06,sep="")
for (i in 2:length(dates)) {
	print(paste(dates[i-1], dates[i]))
	tweets <- c(tweets, searchTwitter("#JOBIM2013", since=dates[i-1], until=dates[i], n=500))
}
 
tweets <- twListToDF(tweets)
tweets <- unique(tweets)

tweets$date <- format(tweets$created, format="%Y-%m-%d")

d <- as.data.frame(table(tweets$screenName))
d <- d[order(d$Freq, decreasing=TRUE), ]
row.names(d)<-NULL
names(d) <- c("User","Tweets")

ggplot(data=d, aes(reorder(User, Tweets), Tweets, fill=Tweets))+
	geom_bar(stat="identity")+
	coord_flip()+
	xlab("User")+
	ylab("Number of tweets")+
	ggtitle("JOBIM 2013 top users")
ggsave(file='jobim-user.png', width=7, height=7, dpi=100)

ggplot(data=tweets, aes(x=created))+
	geom_bar(aes(fill=..count..), binwidth=3600)+
	scale_x_datetime("Date")+
	scale_y_continuous("Frequency")+
	ggtitle("#JOBIM2013 Tweet Frequency")
ggsave(file='jobim-frequency.png', width=7, height=7, dpi=100)