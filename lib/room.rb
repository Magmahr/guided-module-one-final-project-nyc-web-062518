class Room < ActiveRecord::Base

belongs_to :user
has_many :items
has_one :character

end
