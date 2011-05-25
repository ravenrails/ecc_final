class Tag < ActiveRecord::Base
  def self.filter(term)
    term.gsub(/\+/, ' ')
      .gsub(/\s+/, ' ')
      .gsub(/^\s+/, '')
      .gsub(/\s+$/, '')
      .downcase
      .gsub(/[^0-9a-z\s-]/, '')
  end

  def frequency
    self.stories.count
  end

  def self.to_histogram
    Tag.all.inject({}){|set, t| set[t.name] = t.frequency; set }
  end

end
