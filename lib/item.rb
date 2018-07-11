class Item < ActiveRecord::Base

belongs_to :room
belongs_to :user

  def self.five_random_items
    self.all.shuffle[0..4]
  end

  def self.list_of_random_items
    array = five_random_items.map do |item|
      item.name
    end
  end

end
