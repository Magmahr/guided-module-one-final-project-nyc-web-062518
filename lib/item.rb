class Item < ActiveRecord::Base

belongs_to :room
belongs_to :user

  def self.random_items
    if self.all.count >= 5
      self.all.shuffle[0..4]
    elsif self.all.count == 4
      self.all.shuffle[0..3]
    elsif self.all.count == 3
      self.all.shuffle[0..2]
    elsif self.all.count == 2
      self.all.shuffle[0..1]
    else
      self.all[0]
    end
  end

  def self.list_of_random_items
    array = random_items.map do |item|
      item.name
    end
  end



end
