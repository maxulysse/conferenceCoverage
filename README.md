conferenceCoverage
===

ABOUT
---
Get twitter conference coverage based on a hashtag over time with R twitteR package  
Visualization made with ggplot2, scales and wordcloud packages

USAGE
---
./conferenceCoverage.R HASTAG DATE(in YYYY-MM-DD format) LENGH(of conference in day)

EXAMPLES
---
<code>./conferenceCoverage.R #JOBIM2013 2013-06-30 8</code>
<code>./conferenceCoverage.R #ISMBECCB 2013-07-18 9</code>

First argument is the Hastag for the conference (# is not required, but it works if you put it)  
Second argument is the first day of the conference in YYYY-MM-DD format  
Third argument is the lenght in day of the conference

HELP
---
Install twitteR and RCurl package on Ubuntu  
In Shell :  
<code>sudo apt-get install libcurl4-gnutls-dev</code>

In R console :  
<code>install.packages("RCurl")</code>  
<code>install.packages("twitteR")</code>


Help to get pass the OAuth with twitter

Log to your account on twitter.com (or create a new one).  
Go to : https://dev.twitter.com/apps/  
Create a new app to get a consumerKey and a consumerSecret

In a R console :  
<code>library(twitteR)
cred <- OAuthFactory$new(consumerKey="YOURCONSUMERKEY",
	consumerSecret="YOURCONSUMERSECRET",
	requestURL="https://api.twitter.com/oauth/request_token",
	accessURL="https://api.twitter.com/oauth/access_token",
	authURL="http://api.twitter.com/oauth/authorize")
cred$handshake()
registerTwitterOAuth(cred)
save(file="cred",cred)</code>  

The cred file just created contain all your OAuth data.  
So you just had to load it and you can authentify yourself with it.

CREDITS
---
Script is mostly copied and slightly adapted on Neil and Stephen twitter analysis  
https://github.com/neilfws/Twitter  
https://github.com/stephenturner/twitterchive/blob/master/analysis/twitterchive.r  

Informations for installing twitteR and RCurl on Ubuntu :  
http://freakonometrics.hypotheses.org/8256  