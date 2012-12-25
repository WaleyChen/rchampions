# http://developer.yahoo.com/ruby/ruby-rest.html - REST calls with ruby

# NOKOGIRI
# http://nokogiri.org/tutorials/searching_a_xml_html_document.html
# http://cheat.errtheblog.com/s/nokogiri/
require 'mechanize'
require 'net/http'
require 'nokogiri'
require 'open-uri'
# require 'json'

class Scrape
  include Mongoid::Document

  CHAMPIONS = {"Ahri"=>"", "Alistar"=>"", "Amumu"=>"", "Anivia"=>"", "Annie"=>"", "Ashe"=>"", "Blitzcrank"=>"", "Caitlyn"=>"", "Cassiopeia"=>"", "Cho'Gath"=>"", "Corki"=>"", "Janna"=>"", "Karthus"=>"", "Katarina"=>"", "Kog'Maw"=>"", "Lulu"=>"", "Miss Fortune"=>"", "Morgana"=>"", "Orianna"=>"", "Ryze"=>"", "Sion"=>"", "Soraka"=>"", "Swain"=>"", "Taric"=>"", "Teemo"=>"", "Tristana"=>"", "Twisted Fate"=>"", "Veigar"=>"", "Zilean"=>"", "Zyra"=>"", "Brand"=>"", "Ezreal"=>"", "Fizz"=>"", "Galio"=>"", "Gangplank"=>"", "Garen"=>"", "Jax"=>"", "Karma"=>"", "Kennen"=>"", "LeBlanc"=>"", "Lee Sin"=>"", "Leona"=>"", "Lux"=>"", "Pantheon"=>"", "Renekton"=>"", "Shaco"=>"", "Shen"=>"", "Sivir"=>"", "Vladimir"=>"", "Diana"=>"", "Evelynn"=>"", "Fiddlesticks"=>"", "Gragas"=>"", "Graves"=>"", "Irelia"=>"", "Kassadin"=>"", "Malphite"=>"", "Nasus"=>"", "Nautilus"=>"", "Nocturne"=>"", "Nunu"=>"", "Shyvana"=>"", "Singed"=>"", "Sona"=>"", "Tryndamere"=>"", "Udyr"=>"", "Urgot"=>"", "Vayne"=>"", "Warwick"=>"", "Xin Zhao"=>"", "Yorick"=>"", "Fiora"=>"", "Maokai"=>"", "Olaf"=>"", "Skarner"=>"", "Trundle"=>"", "Heimerdinger"=>"", "Jarvan IV"=>"", "Jayce"=>"", "Kayle"=>"", "Master Yi"=>"", "Mordekaiser"=>"", "Nidalee"=>"", "Poppy"=>"", "Rammus"=>"", "Rumble"=>"", "Twitch"=>"", "Wukong"=>"", "Draven"=>"", "Riven"=>"", "Varus"=>"", "Akali"=>"", "Darius"=>"", "Xerath"=>"", "Ziggs"=>"", "Malzahar"=>"", "Talon"=>"", "Hecarim"=>"", "Kha'Zix"=>"", "Rengar"=>"", "Viktor"=>"", "Syndra"=>"", "Sejuani"=>"", "Volibear"=>"", "Zed"=>"", "Elise"=>""}
  RANKINGS = "http://competitive.na.leagueoflegends.com/ladders/na/current/rankedsolo5x5?summoner_name="
  TOTAL_RANKED_COUNT = 247693
  TOP_TWENTY = TOTAL_RANKED_COUNT * 0.2

  STATS = "http://www.lolking.net/search"

  champion_best_summoners = nil

#    # Returns the best matches for person from the prefs dictionary.
#      # Number of results and similarity function are optional params.
#      def topMatches(prefs,person,n=5,similarity=sim_pearson):
#        scores=[(similarity(prefs,person,other),other)
#                        for other in prefs if other!=person]
# # Sort the list so the highest scores appear at the top scores.sort( )
# scores.reverse( )
# return scores[0:n]

  def self.flip_data
    champions = {}

    Summoner.where(:champion_stats.ne => {}).each do |s|
      s.champion_stats.keys.each do |k|
        total_games = s.champion_stats[k]['wins'].to_i + s.champion_stats[k]['losses'].to_i
        next if total_games < 5
        win_ratio = s.champion_stats[k]['wins'].to_i.to_f/total_games

        if !champions.has_key?(k)
          champions[k] = [ [s.name, win_ratio ] ]
        else
          champions[k] = champions[k] << [s.name, win_ratio]
        end
      end

      puts "NEWLINE"
    end

    fd = FlippedData.new
    fd.data = champions
    fd.save
    puts "SAVEYA"
    puts "HACK"
  end


  # Returns a distance-based similarity score for person1 and person2
  def self.sim_champion(champion_1,champion_2)
    # Get the list of shared_items
    si={}

    champion_1.keys.each do |k|
      si[k]=1 if champion_2[k].present?
    end

    # if they have no ratings in common, return 0
    return 0 if si == {}

    # Add up the squares of all the differences
    sum_of_squares = 0
    sum_x = 0
    sum_y = 0
    sum_xy = 0
    sum_x_squared = 0
    sum_y_squared = 0
    n = si.keys.count

    x = []
    y = []
    si.keys.each do |player|
      champion_1_win_ratio = champion_1[player]
      champion_2_win_ratio = champion_2[player]

      sum_of_squares = sum_of_squares + (champion_1_win_ratio - champion_2_win_ratio) ** 2
    end

    1 / ( 1 + Math.sqrt(sum_of_squares))
  end

  # Returns a distance-based similarity score for person1 and person2
  def self.sim_distance(sum_1,sum_2)
    # Get the list of shared_items
    si={}

    sum_1.champion_stats.each do |k,v|
      si[k]=1 if sum_2.champion_stats[k].present?
    end

    # if they have no ratings in common, return 0
    return 0 if si == {}

    # Add up the squares of all the differences
    sum_of_squares = 0
    sum_x = 0
    sum_y = 0
    sum_xy = 0
    sum_x_squared = 0
    sum_y_squared = 0
    n = si.keys.count

    x = []
    y = []
    si.keys.each do |c|
      sum_1_win_ratio = sum_1.champion_stats[c][:wins].to_f/(sum_1.champion_stats[c][:wins] + sum_1.champion_stats[c][:losses])
      sum_2_win_ratio = sum_2.champion_stats[c][:wins].to_f/(sum_2.champion_stats[c][:wins] + sum_2.champion_stats[c][:losses])

      sum_of_squares = sum_of_squares + (sum_1_win_ratio - sum_2_win_ratio) ** 2
    end

    1 / ( 1 + Math.sqrt(sum_of_squares))
  end

  def self.get_champions
    champions = {}

    Summoner.where(:champion_stats.ne => {}).each do |s|
      s.champion_stats.keys.each do |k|
        if !champions.has_key?(k)
          champions[k] = 0
        else
          champions[k] = champions[k] + 1 if s.champion_stats[k]['wins'].to_i + s.champion_stats[k]['losses'].to_i > 5
        end
      end
      puts champions
    end
  end

  def self.check_names
    agent = Mechanize.new
    pg_num = 0
    summoner_count = 0

    while summoner_count <= TOP_TWENTY do
      pg = agent.get("#{ RANKINGS }&page=#{ pg_num }")
      # puts pg.body
      noko_pg = Nokogiri::HTML(pg.body)
      names = noko_pg.css('.views-field-summoner-name-1')

      names.each do |name_node|
        name = name_node.content.strip

        if name != 'PLAYER NAME'
          summoner = Summoner.new
          summoner.name = name

          if Summoner.where(:name => name).count == 1
            puts 'PLAYER FOUND'
          else
            puts 'PLAYER NOT FOUND'
          end

          puts name
          summoner_count = summoner_count + 1
        end
      end

      pg_num = pg_num + 1
      puts summoner_count
      break
    end
  end

  def self.top_twenty_names
    agent = Mechanize.new
    pg_num = 0
    summoner_count = 0

    while summoner_count <= TOP_TWENTY do
      pg = agent.get("#{ RANKINGS }&page=#{ pg_num }")
      # puts pg.body
      noko_pg = Nokogiri::HTML(pg.body)
      names = noko_pg.css('.views-field-summoner-name-1')

      names.each do |name_node|
        name = name_node.content.strip

        if name != 'PLAYER NAME'
          summoner = Summoner.new
          summoner.name = name
          summoner.save
          puts name
          summoner_count = summoner_count + 1
        end
      end

      pg_num = pg_num + 1
      puts summoner_count
    end
  end

  def self.stats_of_top_twenty
    agent = Mechanize.new
    cookie = Mechanize::Cookie.new('enabled-search-regions', 'na')
    cookie.domain = ".lolking.net"
    cookie.path = "/"
    agent.cookie_jar.add!(cookie)

    success_count = 0
    fail_count = 0

    puts Summoner.where(:champion_stats => {}, :no_stats => nil).count
    # 32644 left

    Summoner.where(:champion_stats => {}, :no_stats => nil).each do |summoner|
      stats_pg_url = "#{ STATS }?name=#{ URI::encode(summoner.name) }"
      pg = agent.get(stats_pg_url)
      sname = summoner.name
      puts sname
      # puts pg
      # puts pg.uri.to_s

      stats_pg_url = "#{ pg.uri.to_s }#ranked-stats"
      puts stats_pg_url

      if stats_pg_url.include?('search?name=')
        summoner.no_stats = true
        puts "FAILED TO FIND SUMMONER"
        fail_count = fail_count + 1
        next
      end

      stats_pg = agent.get(stats_pg_url)
      noko_stats_pg = Nokogiri::HTML(stats_pg.body)
      stats = noko_stats_pg.css('.season_2_ranked_stats tbody tr')

      puts stats
      if stats.nil?
        puts "NIL"
      end
      
      champ_stats = {}
      stats.each do |stat_node|
        puts stat_node
        champ_name, wins, losses = stat_node.xpath('./td')
        champ_name = champ_name.content.strip
        wins =  wins.content.strip
        losses = losses.content.strip

        puts champ_name
        puts wins
        puts losses

        champ_stats[champ_name.to_sym] = {:wins => wins, :losses => losses}
      end

      summoner.update_attribute(:champion_stats, champ_stats)
      summoner.reload
      puts summoner.champion_stats

      if summoner.champion_stats == champ_stats && summoner.champion_stats != {}
        success_count = success_count + 1
        puts 'SAVE SUCCEEDED'
      else
        summoner.no_stats = true
        summoner.save
        fail_count = fail_count + 1
        puts 'SAVE FAILED'
      end

      break if success_count == 1
      puts summoner.champion_stats
      puts "Success: #{ success_count }"
      puts "Fail: #{ fail_count }"
      puts Summoner.where(:champion_stats => {}, :no_stats => nil).count
    end
  end
end
