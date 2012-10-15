# http://developer.yahoo.com/ruby/ruby-rest.html - REST calls with ruby

# NOKOGIRI
# http://nokogiri.org/tutorials/searching_a_xml_html_document.html
# http://cheat.errtheblog.com/s/nokogiri/
require 'net/http'
require 'nokogiri'
require 'open-uri'
# require 'json'

class Scrape
  include Mongoid::Document

  def self.indeed
    url = "http://api.indeed.com/ads/apisearch?publisher=4563146977077687&format=json&q=software+developer+intern&jt=internship&v=2"
    resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object
    data = JSON.parse(resp.body)
    total_results = data['totalResults']
    puts total_results

    start = 300

    while start + 25 <= total_results do
      url = "http://api.indeed.com/ads/apisearch?publisher=4563146977077687&format=json&q=software+developer+intern&jt=internship&start=#{ start }&limit=25&v=2"
      resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object
      data = JSON.parse(resp.body)

      puts data.keys
      puts data['start']
      puts data['end']
      puts data['totalResults']

      data['results'].each do |first|
        company = Company.new
        job = Job.new

        job.title =  first['jobtitle']
        company.name = first['company']
        job.city =  first['city']
        job.province = first['state']
        job.country = first['country']
        job.deadline = 'Rolling Basis'

        url = first['url']
        resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object

        if resp.code == "301"
          resp = Net::HTTP.get_response(URI.parse(resp.header['location']))
        else
          puts "#{ resp.code } INSTEAD OF 301"
        end

        data = resp.body

        doc = Nokogiri::HTML(open(url))

        redirect_to_apply_link = ''
        doc.css('.view_job_link').each do |link|
          redirect_to_apply_link = "http://indeed.com#{ link['href'] }"
        end

        # puts 'GOT THE LINK'

        agent = Mechanize.new
        # puts "redirect to apply link is #{ redirect_to_apply_link }"

        unless redirect_to_apply_link.empty?
          begin
            apply_pg = agent.get(redirect_to_apply_link)
          rescue Mechanize::ResponseCodeError => error 
          rescue Mechanize::ResponseCodeError => exception
          end

          job.apply_link = apply_pg.uri.to_s unless apply_pg.nil?
        else
          # puts "IT'S BLANK"
        end

        puts job.inspect
        puts company.inspect

        job.company = company
        company.save
        job.save
      end

      start = start + 25
      puts "parsed #{ start } jobs"

    end
  end

end