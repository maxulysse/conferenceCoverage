# conferenceCoverage

## VERSION
1.1

## ABOUT
Get twitter conference coverage based on a hashtag over time with R twitteR package.

Visualization made with ggplot2, scales and wordcloud packages

## USAGE
```bash
./conferenceCoverage.R HASTAG DATE(in YYYY-MM-DD format) LENGH(of conference in day)
```

- First argument is the Hastag for the conference (I would recommand without #)
- Second argument is the first day of the conference in YYYY-MM-DD format
- Third argument is the lenght in days of the conference

## EXAMPLES
```bash
./conferenceCoverage.R JOBIM2016 2016-06-26 3
```

## HELP
### How to install twitteR and RCurl package on Ubuntu  
In Shell :  
```bash
sudo apt-get install r-base r-base-dev libxml2-dev libcurl4-openssl-dev curl libcairo-dev
```
If problems with svglite, check (github.com)[https://github.com/hadley/svglite]

In R console :
```R
install.packages("devtools", "RCurl", "twitteR", "ggplot2", "tm", "scales", "wordcloud")
```

### How to get pass the twitter credentials working with twitteR
- Log to your account on twitter.com (or create a new one)
- Go to (dev.twitter.com)[https://dev.twitter.com/apps/]
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

## CHANGELOG
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
- (github.com)[https://github.com/neilfws/Twitter]
- (github.com)[https://github.com/stephenturner/twitterchive/blob/master/analysis/twitterchive.r]

Informations for installing twitteR and RCurl on Ubuntu:
- (freakonometrics)[http://freakonometrics.hypotheses.org/8256]