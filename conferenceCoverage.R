#!/usr/bin/Rscript
# usage ./conferenceCoverage.R hashtag YYYY-MM-DD DD
# Mostly copied and slightly adapted from Neil and Stephen twitter analysis

arguments <- commandArgs(TRUE)

hashtag <- tolower(gsub("#", "", arguments[1]))
beginDate <- as.Date(format(arguments[2], format="%Y-%m-%d"))
confLength <- as.integer(arguments[3])

#Loading packages
require(twitteR)
require(tm)
require(ggplot2)
require(scales)
require(wordcloud)

load("cred")
registerTwitterOAuth(cred)

tweets <- list()
dates <- seq(beginDate, len=confLength, by="1 day")

# Recovering tweets, should be done as soon as possible after the end of the conference, it's very hard to get tweets after they get 1 week old
for (i in 2:length(dates)) {tweets <- c(tweets, searchTwitter(paste("#", hashtag, sep=""), since=paste(dates[i-1]), until=paste(dates[i]), n=2000))}
# 2000 Is a big enough number for tweets per day for a conf as big as ISMBECCB, should try other value depending on API limits

tweets <- twListToDF(tweets)
tweets <- unique(tweets)

# Probably a spam (I found only RTs on his profile)
tweets <- tweets[which(tweets$screenName!="sciencestream"), ]

dfTweets <- as.data.frame(table(tweets$screenName))
row.names(dfTweets) <- NULL
names(dfTweets) <- c("User", "Tweets")

# Plotting top 40 users (or less if there is less tha 40 users)
# 40 Should be enough considering that most people only tweet once
# Should try to filter out people tweeting only once
ggplot(data=dfTweets[rev(1:40), ], aes(reorder(User, Tweets), Tweets, fill=Tweets))+
	geom_bar(stat="identity")+
	coord_flip()+
	xlab("User")+
	ylab("Number of tweets")+
	theme(legend.position="none")+
	ggtitle(paste("#", toupper(hashtag), " Top Users", sep=""))
ggsave(file=paste(hashtag, "user.png", sep="-"), width=8, height=8, dpi=100)

# Plotting Tweet Frequency during the day
ggplot(data=tweets, aes(created))+
	geom_bar(aes(fill=..count..), binwidth=4800)+
	scale_x_datetime("Date", breaks = date_breaks("12 hours"), labels = date_format("%b %d %HH"))+
	scale_y_continuous("Frequency")+
	theme(legend.position="none", axis.text.x = element_text(angle=45, hjust = 1, vjust = 1))+
	ggtitle(paste("#", toupper(hashtag), " Tweet Frequency", sep=""))
ggsave(file=paste(hashtag, "frequency.png", sep="-"), width=8, height=8, dpi=100)

# Plotting a wordcloud
words <- unlist(strsplit(tweets$text, " "))
words <- grep("^[A-Za-z0-9]+$", words, value=T)
words <- tolower(words)
words <- words[!(words %in% stopwords("en"))]
# remove RTs, MTs, via, single digits and hashtag
words <- words[!(words %in% c("mt", "rt", "via", "using", 0:9, hashtag))]
wordstable <- as.data.frame(table(words))
wordstable <- wordstable[order(wordstable$Freq, decreasing=T), ]
png(paste(hashtag, "wordcloud.png", sep="-"), w=800, h=800)
wordcloud(wordstable$words, wordstable$Freq, scale = c(6, .2), min.freq = 2, max.words = 500, random.order = FALSE, rot.per = .15, colors = brewer.pal(9, "Blues"))
dev.off()