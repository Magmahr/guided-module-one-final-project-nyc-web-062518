class User < ActiveRecord::Base

has_many :items
has_many :rooms, through: :items

  def get_user_name
    puts "If I could please have your name?"
    input = gets.chomp
    self.name = input
  end

  def get_user_role
    prompt = TTY::Prompt.new
    input = prompt.select("Select a role for your player:", %w(Sleuth Trouble Influencer Bystander Globetrekker))
    self.role = input
  end

end
