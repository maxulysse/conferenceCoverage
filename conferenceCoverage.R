#!/usr/bin/Rscript

# -----------------------------------------------------------------------------
# "THE NOT-A-BEER-WARE LICENSE" (Revision 42):
# <max@ithake.eu> wrote this file.  As long as you retain this notice you
# can do whatever you want with this stuff.  If we meet some day, and you think
# this stuff is worth it, you can buy me not a beer in return.  Maxime
# -----------------------------------------------------------------------------

# Loading packages
suppressPackageStartupMessages(require(optparse))
suppressPackageStartupMessages(require(twitteR))
suppressPackageStartupMessages(require(tm))
suppressPackageStartupMessages(require(ggplot2))
suppressPackageStartupMessages(require(scales))
suppressPackageStartupMessages(require(wordcloud))

# Handling arguments
option_list <- list(
make_option(c("-a", "--hashtag"), type="character", dest="hashtag",
	help="Hashtag of the event (without the #)"),
make_option(c("-d", "--date"), type="character", dest="beginDate", metavar="YYYY-MM-DD",
	help="Beginning date of the event"),
make_option(c("-l", "--lenght"), type="integer", dest="confLength",
	help="Length of the event"),
	# Since most people tweet only a few time you might want to filter out some
make_option(c("-f", "--minFilter"), type="integer", dest="minFilter", default=3,
	help="Minimun of tweets to keep a userin the top user graph [default %default]"),
	# Could be more if you have more people tweeting, but the top 40 or 50 users is nice enough
make_option(c("-u", "--maxUsers"), type="integer", dest="maxUsers", default=40,
	help="Maximum number of users for the top user graph [default %default]"),
	# 1500 should be a big enough number for tweets per day for a conference.
make_option(c("-t", "--maxTweets"), type="integer", dest="maxTweets", default=1500,
	help="Maximum number of tweets per day required to the API [default %default]"),
make_option(c("-v", "--version"), action="store_true", dest="version",
	help="Print version number and exit")
)

opt <- parse_args(OptionParser(usage = "usage: %prog -a HASHTAG -d BEGINDATE -l CONFLENGTH [options]",option_list=option_list))

if (!is.null(opt$version)) {
	stop("conferenceCoverage version 1.3")
}

# Handling empty mandatory arguments
if (is.null(opt$hashtag) || is.null(opt$beginDate) || is.null(opt$confLength) ) {
	stop("hashtag, beginDate and confLength parameters must be provided. See script usage (--help)")
}

hashtag <- tolower(opt$hashtag)
beginDate <- as.Date(opt$beginDate, format="%Y-%m-%d")

# Get twitter credentials
load("cred")
setup_twitter_oauth(consumer_key,
					consumer_secret,
					access_token,
					access_secret)

tweets <- list()
dates <- seq.Date(beginDate, by="days", length.out=opt$confLength)

# Recovering tweets, should be done as soon as possible after the end of the conference, it's very hard to get tweets after some time
for (i in 2:length(dates)) {tweets <- c(tweets, searchTwitter(paste("#", hashtag, sep=""), since=paste(dates[i-1]), until=paste(dates[i]), n=opt$maxTweets))}

tweets <- twListToDF(tweets)
tweets <- unique(tweets)

dfTweets <- as.data.frame(table(tweets$screenName))
names(dfTweets) <- c("User", "Tweets")

# Filtering out people tweeting less than opt$minFilter times
dfTweets <- subset(dfTweets, Tweets>opt$minFilter)

# Plotting top opt$maxUsers users (or less if there is less than opt$maxUsers users)
ggplot(data=dfTweets[rev(1:min(nrow(dfTweets),opt$maxUsers)), ], aes(reorder(User, Tweets), Tweets, fill=Tweets))+
	geom_bar(stat="identity")+
	coord_flip()+
	xlab("User")+
	ylab("Number of tweets")+
	theme(legend.position="none")+
	ggtitle(paste("#", toupper(hashtag), " Top Users", sep=""))
ggsave(file=paste(hashtag, "user.png", sep="-"), width=8, height=8, dpi=100)
ggsave(file=paste(hashtag, "user.svg", sep="-"), width=8, height=8)

write.table(dfTweets, file=(paste(hashtag, "users.txt", sep="-")))

# Plotting Tweet Frequency during the days of the event
ggplot(data=tweets, aes(created))+
	geom_histogram(aes(fill=..count..), binwidth=4800)+
	scale_x_datetime("Date", breaks = date_breaks("12 hours"), labels = date_format("%b %d %HH"))+
	scale_y_continuous("Frequency")+
	theme(legend.position="none", axis.text.x = element_text(angle=45, hjust = 1, vjust = 1))+
	ggtitle(paste("#", toupper(hashtag), " Tweet Frequency", sep=""))
ggsave(file=paste(hashtag, "frequency.png", sep="-"), width=8, height=8, dpi=100)
ggsave(file=paste(hashtag, "frequency.svg", sep="-"), width=8, height=8)

# Plotting a wordcloud
words <- unlist(strsplit(tweets$text, " "))
words <- grep("^[A-Za-z0-9]+$", words, value=T)
words <- tolower(words)
words <- words[!(words %in% stopwords("en"))]
words <- words[!(words %in% stopwords("fr"))]
# remove RTs, MTs, via, single digits and hashtag
words <- words[!(words %in% c("mt", "rt", "via", "using", "cc", 0:9, hashtag))]
wordstable <- as.data.frame(table(words))
wordstable <- wordstable[order(wordstable$Freq, decreasing=T), ]

png(paste(hashtag, "wordcloud.png", sep="-"), w=800, h=800)
wordcloud(wordstable$words, wordstable$Freq, scale = c(6, .2), min.freq = 2, max.words = 500, random.order = FALSE, rot.per = .15, colors = brewer.pal(9, "Blues"))
dev.off()

svg(paste(hashtag, "wordcloud.svg", sep="-"), w=8, h=8)
wordcloud(wordstable$words, wordstable$Freq, scale = c(6, .2), min.freq = 2, max.words = 500, random.order = FALSE, rot.per = .15, colors = brewer.pal(9, "Blues"))
dev.off()

write.table(tweets, file=(paste(hashtag, "tweets.txt", sep="-")))