# conferenceCoverage <img alt="conferenceCoverage Logo" src="http://i.imgur.com/TpCB7HW.png" height=50 /> 1.3.5

## ABOUT
Get twitter conference coverage based on a hashtag over time with [R](https://www.r-project.org/) [twitteR](https://github.com/geoffjentry/twitteR) package.

Visualization made with [ggplot2](http://ggplot2.org/), [scales](https://github.com/hadley/scales/) and [wordcloud](https://cran.r-project.org/web/packages/wordcloud/index.html) packages

## USAGE
```bash
./conferenceCoverage.R -a HASTAG -d DATE -l LENGTH [-f MINFILTER -u MAXUSERS -t MAXTWEETS]
```

- HASTAG is the hastag for the conference (without #)
- DATE is the first day of the conference in YYYY-MM-DD format
- LENGTH is the length in days of the conference
- MINFILTER is the minimum number of tweets/user in the top user graph [default is 3]
- MAXUSERS is the maximum number of users in the top user graph [default is 40]
- MAXTWEETS is the maximum number of tweet/day required by the API [default is 1500]

## EXAMPLES
```bash
./conferenceCoverage.R -a JOBIM2016 -d 2016-06-26 -l 5
./conferenceCoverage.R -a JOBIM2016 -d 2016-06-26 -l 5 -f 5 -u 25 -t 1000
```

## HELP
### How to install twitteR and RCurl package on Ubuntu
In Shell:
```bash
sudo apt-get install r-base r-base-dev libxml2-dev libcurl4-openssl-dev curl libcairo-dev
```
If problems with svglite, check [github.com/hadley](https://github.com/hadley/svglite)

In R console:
```R
install.packages("devtools")
install.packages("RCurl")
install.packages("twitteR")
install.packages("ggplot2")
install.packages("tm")
install.packages("scales")
install.packages("wordcloud")
install.packages("optparse")
```

### How to get pass the twitter credentials working with twitteR
- Log to your account on twitter.com (or create a new one)
- Go to [dev.twitter.com](https://dev.twitter.com/apps/)
- Create an app to get a consumerKey and a consumerSecret

In a R console :
```
library(twitteR)  
consumer_key <- 'YOURCONSUMERKEY'
consumer_secret <- 'YOURCONSUMERSECRET'
access_token <- 'YOURACCESSTOKEN'
access_secret <- 'YOURACCESSSECRET'
save(list = c("consumer_key", "consumer_secret", "access_token", "access_secret"), file="cred")
```

The cred file just created contain all your credentials for Twitter, so don't share it on Github ;-). Now you just had to load it and you can authentify yourself with it.

## TO DO
* Add more stuff:
    - Choice of color theme

## CHANGELOG
### Version 1.3.5:
* Add a logo

### Version 1.3:
* Add NOT-A-BEER-WARE LICENSE

### Version 1.2:
* Add [optparse](https://github.com/trevorld/optparse) for handling arguments
* No longer positionnal arguments
* Add max number of tweets per day requested to twitter API as an option
* Add min number of tweets for top user graph as an option
* Add number of users on the top user graph as an option

### Version 1.1.1:
* Add a min number of tweets for top user graph

### Version 1.1:
* update Twitter logging due to changes in API
* update script
* update help

### Version 1.0:
* add version number and changelog

### Version β:
* add research saving
* add SVG pictures
* add help

### Version α:
* project creation

## LICENSE
---
"THE NOT-A-BEER-WARE LICENSE" (Revision 42): [@MaxUlysse](https://github.com/MaxUlysse) wrote this file.  As long as you retain this notice you can do whatever you want with this stuff.  If we meet some day, and you think this stuff is worth it, you can buy me not a beer in return.

---

## NOTES
Script is mostly copied and slightly adapted on Neil and Stephen twitter analysis:
- [github.com/neilfws](https://github.com/neilfws/Twitter)
- [github.com/stephenturner](https://github.com/stephenturner/twitterchive/blob/master/analysis/twitterchive.r)

Informations for installing twitteR and RCurl on Ubuntu:
- [freakonometrics](http://freakonometrics.hypotheses.org/8256)
