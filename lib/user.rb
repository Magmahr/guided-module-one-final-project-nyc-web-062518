class User < ActiveRecord::Base

has_many :rooms
has_many :items, through: :rooms
has_many :characters, through: :rooms

# attr_accessor :name, :role
#
# def initialize(name= nil, role = nil)
#   @name = name
#   @role = role
# end

end
