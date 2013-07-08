#!/usr/bin/Rscript --vanilla
# usage ./conferenceCoverage.R hashtag YYYY-MM-DD DD

require(twitteR)
require(ggplot2)
require(tm)
require(wordcloud)
require(scales)

args <- commandArgs(TRUE)
hashtag <- tolower(gsub("#", "", args[1]))
beginDate <- as.Date(format(args[2], format="%Y-%m-%d"))
conferenceLength <- as.integer(args[3])

load("cred")
registerTwitterOAuth(cred)

tweets <- list()
dates <- seq(beginDate, len=conferenceLength, by="1 day")
for (i in 2:length(dates)) {
	tweets <- c(tweets, searchTwitter(paste("#", hashtag, sep=""), since=paste(dates[i-1]), until=paste(dates[i]), n=2000))
}
tweets <- twListToDF(tweets)
tweets <- unique(tweets)

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

ggplot(data=tweets, aes(created))+
	geom_bar(aes(fill=..count..), binwidth=4800)+ #should be relative to the number of tweets and the number of days, but 4800 feels good for this one
	scale_x_datetime("Date", breaks = date_breaks("12 hours"), labels = date_format("%b %d %HH"))+
	scale_y_continuous("Frequency")+
	theme(legend.position="none", axis.text.x = element_text(angle=45, hjust = 1, vjust = 1))+
	ggtitle(paste("#", toupper(hashtag), " Tweet Frequency", sep=""))
ggsave(file=paste(hashtag, "frequency.png", sep="-"), width=8, height=8, dpi=100)

words <- as.data.frame(unlist(strsplit(tweets$text, " ")))
corpus <- Corpus(DataframeSource(words))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, tolower)
png(paste(hashtag, "wordcloud.png", sep="-"), w=500, h=500)
wordcloud(corpus, scale=c(8, 0.5), min.freq=3, max.words=200, random.order=TRUE, rot.per=0.15)