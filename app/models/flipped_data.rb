class FlippedData
  include Mongoid::Document

  field :data
  field :hashed_data
  field :fhashed_data
  field :similar_champions

  def filter_hashed_data
    fhashed_data = {}

    self.hashed_data.keys.each do |champ|
      champ_stats = {}

      hashed_data[champ].each do |k, v|
        puts k
        champ_stats[k] = v if v > 0.70
      end

      fhashed_data[champ] = champ_stats
    end
    
    self.fhashed_data = fhashed_data
    self.save
  end

  def sort
    self.data.keys.each do |k|
      self.data[k] = self.data[k].sort{|a,b| b.last <=> a.last }
    end
    self.save
  end

  def to_hash
    self.hashed_data = {}

    self.data.keys.each do |k|

      players = {}
      self.data[k].each do |v|
        players[v.first] = v.last
      end
      self.hashed_data[k] = players

    end
    self.save
  end

  def sort_hash
    self.similar_champions.keys.each do |k|
      self.similar_champions[k] = self.similar_champions[k].sort_by{|player, rating| rating }.reverse

      players = {}
      self.similar_champions[k].each do |v|
        players[v.first] = v.last
      end
      self.similar_champions[k] = players

    end
    
    self.similar_champions
    self.save
  end

  def calc_similar_champions_2
    self.similar_champions = {}
    self.fhashed_data.each do |k_1, v_1|

      sim_champs = {}
      self.fhashed_data.each do |k_2, v_2|
        next if k_1 == k_2
        sim_champs[k_2] = Scrape.sim_champion(v_1, v_2)
      end
      self.similar_champions[k_1] = sim_champs

    end

    self.save
  end

  def calc_similar_champions
    self.similar_champions = {}
    self.hashed_data.each do |k_1, v_1|

      sim_champs = {}
      self.hashed_data.each do |k_2, v_2|
        next if k_1 == k_2
        sim_champs[k_2] = Scrape.sim_champion(v_1, v_2)
      end
      self.similar_champions[k_1] = sim_champs

    end

    self.save
  end
end