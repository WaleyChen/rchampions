# http://developer.yahoo.com/ruby/ruby-rest.html - REST calls with ruby

# NOKOGIRI
# http://nokogiri.org/tutorials/searching_a_xml_html_document.html
# http://cheat.errtheblog.com/s/nokogiri/
require 'mechanize'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'json'

url = 'http://api.indeed.com/ads/apisearch?publisher=4563146977077687&format=json&q=software+developer+intern&jt=internship&limit=25&v=2'
resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object

data = JSON.parse(resp.body)

first = data['results'].first
# puts first
# puts first['jobtitle']
# puts first['company']
# puts first['city']
# puts first['state']
# puts first['country']

# {"jobtitle"=>"Custom Software Developer Intern", "company"=>"MTS Systems Corporation", "city"=>"Eden Prairie", "state"=>"MN", "country"=>"US", 
#   "formattedLocation"=>"Eden Prairie, MN", "source"=>"MTS Systems Corporation", "date"=>"Thu, 11 Oct 2012 16:59:54 GMT", 
#   "snippet"=>"A summer <b>software</b> engineering <b>intern</b> position is... will include: Work with a team of <b>software</b> 
#   <b>developers</b> designing and implementing <b>software</b> for PC based... ",
#    "url"=>"http://www.indeed.com/viewjob?jk=cd5b07bdcffe51cd&qd=aSwaFfStX-FP03_scbf6BnemPwnI53vroMa4unfo9TbVTN5sISGqen17Zbv34VS2iOtLzlLcx6SQtAsqEQosB698SmLbgrea7lgDr-6AOZ2QhwggWUZEvHtN5OcDtAPb&indpubnum=4563146977077687&atk=179drg45t0k4163j", "onmousedown"=>"indeed_clk(this, '400');", 
#    "jobkey"=>"cd5b07bdcffe51cd", "sponsored"=>false, "expired"=>false, "formattedLocationFull"=>"Eden Prairie, MN",
#     "formattedRelativeTime"=>"2 days ago"}

url = 'http://www.indeed.com/viewjob?jk=cd5b07bdcffe51cd&qd=aSwaFfStX-FP03_scbf6BnemPwnI53vroMa4unfo9TbVTN5sISGqen17Zbv34VS2iOtLzlLcx6SQtAsqEQosB698SmLbgrea7lgDr-6AOZ2QhwggWUZEvHtN5OcDtAPb&indpubnum=4563146977077687&atk=179drg45t0k4163j'
resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object

if resp.code == "301"
  resp = Net::HTTP.get_response(URI.parse(resp.header['location']))
end

data = resp.body

doc = Nokogiri::HTML(open(url))

redirect_to_apply_link = ''
doc.css('.view_job_link').each do |link|
  redirect_to_apply_link = "http://indeed.com#{ link['href'] }"
end

# puts 'GOT THE LINK'
agent = Mechanize.new
apply_pg = agent.get(redirect_to_apply_link)
puts apply_pg.uri.to_s 

# url = redirect_to_apply_link
# resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object

# if resp.code == "301"
#   resp = Net::HTTP.get_response(URI.parse(resp.header['location']))
# end

