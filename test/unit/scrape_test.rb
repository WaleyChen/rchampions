require 'debugger'
require 'test_helper'

class ScrapeTest < ActiveSupport::TestCase
 
  test "the truth" do
    s1 = Summoner.new
    s2 = Summoner.new

    s1.champion_stats = {:Waley => {:wins => 5, :losses => 2}, :Tim => {:wins => 5, :losses => 2}}
    s2.champion_stats = {:Waley => {:wins => 5, :losses =>2}, :Tim => {:wins => 5, :losses => 2}}

    s1.save
    s2.save

    puts Scrape.sim_distance(s1, s2)
    assert Scrape.sim_distance(s1, s2) > 0.98

    s1.champion_stats = {:Waley => {:wins => 4, :losses => 2}, :Tim => {:wins => 4, :losses => 2}}
    s2.champion_stats = {:Waley => {:wins => 2, :losses => 1}, :Tim => {:wins => 2, :losses => 1}}

    s1.save
    s2.save

    puts "res"
    assert Scrape.sim_distance(s1, s2) > 0.98
    puts "res"

    s1.champion_stats = {:Waley => {:wins => 4, :losses => 2}, :Tim => {:wins => 4, :losses => 2}}
    s2.champion_stats = {:Waley => {:wins => 2, :losses => 1}, :Tim => {:wins => 3, :losses => 1}}

    s1.save
    s2.save

    puts "res"
    res = Scrape.sim_distance(s1, s2)
    puts res
    assert res < 1
    assert res > 0.5
  end
 
end