require 'oauth'
require 'json'
# # # # # # # # # # # # # # # # # # WARNING # # # # # # # # # # # # # # 
# Use environment variables if you upload the code online i.e. github.
# Something like this
# consumer_key = ENV['YELP_CONSUMER_KEY']
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# This are not real keys, replace with your own
consumer_key = '4_cRfLXaA3HeZNHrbBD9yT'
consumer_secret = 'JTIbnThLgilI91hmpO9BVzsKAKM'
access_token = 'dDRxF9xG4I6bU20jJpIsNd6i8k7Nug-C'
access_token_secret = 'vTlu5EoDInHqsls2UtwX4-zBGoI'

@consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {site: 'http://api.yelp.com'})
access_token = OAuth::AccessToken.new(@consumer, access_token, access_token_secret)


term = 'restaurant'
location = 'santa+monica'

my_response_body = JSON.parse(access_token.get("/v2/search?term=#{term}&location=#{location}").body)

puts my_response_body
