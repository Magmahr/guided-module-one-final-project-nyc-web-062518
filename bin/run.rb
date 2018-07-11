require_relative '../config/environment'
require "pry"

ActiveRecord::Base.logger.level = 1

def welcome_user
  puts "Welcome to the Dinner Party!"
end

def party_background_info
  # to add: background about the party, why you're there, why you realize you need to escape
end

def create_new_user
  user_instance = User.create(name: nil, role: nil)
  user_instance.name = user_instance.get_user_name
  user_instance.role = user_instance.get_user_role
  user_instance.save
end

def join_the_party
  #have option to go back and 1) change UN/role, 2) view background_info again
  prompt = TTY::Prompt.new
  prompt.select("Are you ready to join the party?", %w(Yes! Nope!))
end

def check_if_ready_to_play
  response = join_the_party
  if response == "Yes!"
    navigate_into_a_room
  else join_the_party
  end
end

def navigate_into_a_room
  prompt = TTY::Prompt.new
  prompt.keypress("Press arrow keys (↑ → ↓ ←) to move between rooms.", keys: [:keyup, :keyright, :keydown, :keyleft])
end

def describe_a_room
  puts "You find yourself in a #{Room.random_room} with the following items:"
end

def pick_an_item
  prompt = TTY::Prompt.new
  prompt.select("Please pick one item:", Item.list_of_random_items)
end

def check_if_right_item
  chosen_item = pick_an_item
  chosen_item == Item.all[6].name
end

def correct_item_chosen
  puts "Congrats you've escaped!"
end

def wrong_item_chosen
  puts "That's a nifty #{chosen_item}, but it's probably not going to help you to get out of the house. You should explore another room."
end

# def delete item from database that you just selected


def play_the_game
  welcome_user
  create_new_user
  check_if_ready_to_play
  describe_a_room
  enter_a_room
  check_if_right_item
end

play_the_game
