require_relative '../config/environment'
require "pry"

ActiveRecord::Base.logger.level = 1

def welcome_user
  puts "Welcome to...
  "

  puts <<-HEREDOC
  ~~~888~~~ 888
     888    888-~88e  e88~~8e
     888    888  888 d888  88b
     888    888  888 8888__888
     888    888  888 Y888    ,
     888    888  888  "88___/


  888~-_   ,e,
  888   \\   "  888-~88e 888-~88e  e88~~8e  888-~\\
  888    | 888 888  888 888  888 d888  88b 888
  888    | 888 888  888 888  888 8888__888 888
  888   /  888 888  888 888  888 Y888    , 888
  888_-~   888 888  888 888  888  "88___/  888


  888~-_                      d8
  888   \\    /~~~8e  888-~\\ _d88__ Y88b  /
  888    |       88b 888     888    Y888/
  888   /   e88~-888 888     888     Y8/
  888_-~   C888  888 888     888      Y
  888       "88_-888 888     "88_/   /
                                   _/
HEREDOC
end


def the_setup
  puts "You're driving through a strange town at night when your car breaks down. It's pouring rain, you suspect that you've lost your way and the only house within sight is a vast, sprawling mansion. Every window is lit and you can see a number of people inside, so you decide to go and ask to use a telephone."
  puts "You're greeted at the door by a stranger."
end

def create_new_user
  user_instance = User.create(name: nil, role: nil)
  user_instance.name = user_instance.get_user_name
  user_instance.role = user_instance.get_user_role
  user_instance.save
end

def get_asked_in
  puts "Before you can begin to explain your plight, the stranger at the door thanks you for coming and welcomes you in. You decide to play along, since it's not every day you're invited to a dinner party at an estate as magnificent as this."
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
  prompt.keypress("Press the space key to move between rooms.", keys: [:space])
end

def describe_a_room
  puts "You find yourself in a #{Room.random_room} with the following items:"
end

def pick_an_item
  prompt = TTY::Prompt.new
  prompt.select("Please pick one item:", Item.list_of_random_items)
end

def delete_chosen_item(item)
  Item.all.find do |i|
    if item == i.name
      i.destroy
    end
  end
end

def compare_items
  chosen_item = pick_an_item
  delete_chosen_item(chosen_item)
  if chosen_item == Item.all[0].name
    puts "Congrats, you've escaped!"
  else
    puts "That's a nifty #{chosen_item}, but it's probably not going to help you to get out of the house. You should explore another room."
    explore_another_room
  end
end

def explore_another_room
  navigate_into_a_room
  describe_a_room
  compare_items
end
# def delete item from database that you just selected

def play_the_game
  welcome_user
  the_setup
  create_new_user
  get_asked_in
  check_if_ready_to_play
  describe_a_room
  compare_items
end

play_the_game
