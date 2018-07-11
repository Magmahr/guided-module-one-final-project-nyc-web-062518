class User < ActiveRecord::Base

has_many :items
has_many :rooms, through: :items

#initialize new user and puts out a welcome/intro message

  def get_user_name
    puts "Please enter your name."
    input = gets.chomp
    self.name = input
  end

  def get_user_role
    prompt = TTY::Prompt.new
    input = prompt.select("Select a role for your player:", %w(Sleuth Trouble Influencer Bystander Globetrekker))
    self.role = input
  end


end
