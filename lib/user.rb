class User < ActiveRecord::Base

has_many :rooms
has_many :items, through: :rooms
has_many :characters, through: :rooms

end
