Register to dev.twitter.com
Create a new app
Keep the consumerKey and the consumerSecret
And fill them in the following lines
Launch R
and copy paste the code.


library(twitteR)

cred <- OAuthFactory$new(consumerKey="-------------------",
consumerSecret="-----------------------------------------",
requestURL="https://api.twitter.com/oauth/request_token",
accessURL="https://api.twitter.com/oauth/access_token",
authURL="http://api.twitter.com/oauth/authorize")

cred$handshake()

registerTwitterOAuth(cred)

save(file="cred",cred)