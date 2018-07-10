class Room < ActiveRecord::Base

belongs_to :user
has_many :items
has_one :character

# attr_reader :name, :character, :item
#
# def initialize(name, character, item)
#   @name = name
#   @character = character
#   @item = item
# end

end
