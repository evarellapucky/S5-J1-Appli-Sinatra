require 'csv'
require 'pry'

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end
  
  def save
    CSV.open("./db/gossip.csv", "a") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all 
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    all_gossips = self.all
    all_gossips[id.to_i - 1]
  end

  def self.update(id, new_content)
    gossips = []
    CSV.read("./db/gossip.csv").each_with_index do |row, index| 
        if (id.to_i - 1) == (index)
          gossips << [row[0], new_content]
        else
          gossips << [row[0], row[1]]
        end
      end
      CSV.open("./db/gossip.csv", "w+") do |csv|
        gossips.each do |row|
          csv << row
        end
      end
    end
end

# binding.pry