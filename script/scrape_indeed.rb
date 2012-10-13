# http://developer.yahoo.com/ruby/ruby-rest.html - REST calls with ruby
require 'net/http'
require 'json'

url = 'http://api.indeed.com/ads/apisearch?publisher=4563146977077687&format=json&q=software+developer+intern&jt=internship&limit=25&v=2'
resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object

data = JSON.parse(resp.body)

puts data.keys