# conferenceCoverage

## VERSION
1.2

## ABOUT
Get twitter conference coverage based on a hashtag over time with R twitteR package.

Visualization made with ggplot2, scales and wordcloud packages

## USAGE
```bash
./conferenceCoverage.R -a HASTAG -d DATE(YYYY-MM-DD) -l LENGH(in day)
```

- First argument is the Hastag for the conference (I would recommand without #)
- Second argument is the first day of the conference in YYYY-MM-DD format
- Third argument is the lenght in days of the conference

## EXAMPLES
```bash
./conferenceCoverage.R -a JOBIM2016 -d 2016-06-26 -l 4
./conferenceCoverage.R -a JOBIM2016 -d 2016-06-26 -l 4 -f 5 -u 25 -t 1000
```

## HELP
### How to install twitteR and RCurl package on Ubuntu  
In Shell :  
```bash
sudo apt-get install r-base r-base-dev libxml2-dev libcurl4-openssl-dev curl libcairo-dev
```
If problems with svglite, check [github.com/hadley](https://github.com/hadley/svglite)

In R console :
```R
install.packages("devtools", "RCurl", "twitteR", "ggplot2", "tm", "scales", "wordcloud")
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
- Add license
- Choice of color theme

## CHANGELOG
### Version 1.2:
* Add optparse for handling arguments
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

### Version beta:
* add research saving
* add SVG pictures
* add help

### Version alpha:
* project creation

## CREDITS
Script is mostly copied and slightly adapted on Neil and Stephen twitter analysis:
- [github.com/neilfws](https://github.com/neilfws/Twitter)
- [github.com/stephenturner](https://github.com/stephenturner/twitterchive/blob/master/analysis/twitterchive.r)

Informations for installing twitteR and RCurl on Ubuntu:
- [freakonometrics](http://freakonometrics.hypotheses.org/8256)