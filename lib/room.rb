class Room < ActiveRecord::Base

has_many :items
has_many :users, through: :items

end
