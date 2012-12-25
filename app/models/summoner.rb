class Summoner
  include Mongoid::Document

  field :name
  field :champion_stats, :default => {}
  field :no_stats, :type => Boolean, :default => false
  field :id
end