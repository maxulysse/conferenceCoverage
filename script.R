#!/usr/bin/Rscript --vanilla
#TODO usage #HASGTAG YYYY-MM-DD YYYYMM-DD

require(twitteR)
require(ggplot2)
require(tm)
require(wordcloud)

load("cred")
registerTwitterOAuth(cred)

hashtag="jobim2013"
hashtag<-tolower(hashtag)

tweets <- list()
dates <- paste("2013-07-",01:08,sep="")
for (i in 2:length(dates)) {
	tweets <- c(tweets, searchTwitter(paste("#", hashtag, sep=""), since=dates[i-1], until=dates[i], n=2000))
}
tweets <- twListToDF(tweets)
tweets <- unique(tweets)

tweets$date <- format(tweets$created, format="%Y-%m-%d")

d <- as.data.frame(table(tweets$screenName))
row.names(d)<-NULL
names(d) <- c("User","Tweets")

ggplot(data=d, aes(reorder(User, Tweets), Tweets, fill=Tweets))+
	geom_bar(stat="identity")+
	coord_flip()+
	xlab("User")+
	ylab("Number of tweets")+
	theme(legend.position="none")+
	ggtitle(paste("#", toupper(hashtag), " Top Users", sep=""))
ggsave(file=paste(hashtag, "user.png", sep="-"), width=8, height=8, dpi=100)

ggplot(data=tweets, aes(x=created))+
	geom_bar(aes(fill=..count..), binwidth=3600)+
	scale_x_datetime("Date")+
	scale_y_continuous("Frequency")+
	theme(legend.position="none")+
	ggtitle(paste("#", toupper(hashtag), " Tweet Frequency", sep=""))
ggsave(file=paste(hashtag, "frequency.png", sep="-"), width=8, height=8, dpi=100)

words <- as.data.frame(unlist(strsplit(tweets$text, " ")))
corpus <- Corpus(DataframeSource(words))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, tolower)
png(paste(hashtag, "wordcloud.png", sep="-"), w=500, h=500)
wordcloud(corpus, scale=c(8, 0.5), min.freq=3, max.words=200, random.order=TRUE, rot.per=0.15)
