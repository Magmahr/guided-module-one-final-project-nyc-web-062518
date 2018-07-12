class Room < ActiveRecord::Base

has_many :items
has_many :users, through: :items
has_one :character

  def self.random_room
    self.all.shuffle[0].name
  end


end
