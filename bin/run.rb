require_relative '../config/environment'
require "pry"

ActiveRecord::Base.logger.level = 1

ITEM_ARRAY = []

def line_break
  " "
end

def welcome_user
  puts "Welcome to..."
  line_break
  sleep(1)
  puts <<-HEREDOC
  ~~~888~~~ 888
     888    888-~88e  e88~~8e
     888    888  888 d888  88b
     888    888  888 8888__888
     888    888  888 Y888    ,
     888    888  888  "88___/

HEREDOC
sleep(1)
puts <<-HEREDOC
  888~-_   ,e,
  888   \\   "  888-~88e 888-~88e  e88~~8e  888-~\\
  888    | 888 888  888 888  888 d888  88b 888
  888    | 888 888  888 888  888 8888__888 888
  888   /  888 888  888 888  888 Y888    , 888
  888_-~   888 888  888 888  888  "88___/  888

HEREDOC
sleep(1)
puts <<-HEREDOC
  888~-_                      d8
  888   \\    /~~~8e  888-~\\ _d88__ Y88b  /
  888    |       88b 888     888    Y888/
  888   /   e88~-888 888     888     Y8/
  888_-~   C888  888 888     888      Y
  888       "88_-888 888     "88_/   /
                                   _/
HEREDOC
sleep(2)
line_break
puts "A game by Claudia & Matt"
line_break
sleep(2)
end

def the_setup
  puts "You're driving through a strange town at night when your car breaks down. It's pouring rain, you suspect that you've lost your way and the only house within sight is a vast, sprawling mansion."
  sleep(4)
  puts "The lights in every window are lit and you can see a number of people inside, so you decide to go and ask to use a telephone."
  sleep(3)
  puts "A stranger opens the door and eyes you suspiciously."
  sleep(2)
end

def create_new_user
  user_instance = User.create(name: nil, role: nil)
  user_instance.name = user_instance.get_user_name
  user_instance.role = user_instance.get_user_role
  user_instance.save
end

def get_asked_in
  puts "The stranger shows little interest as you introduce yourself, and before you can begin to explain your plight, they interrupt you."
  sleep(2)
  puts "'Welcome, #{User.last.name}, please, come in. The dinner portion of our evening has just concluded, but the party is now enjoying drinks in the sitting room. You’ll find your hostess inside.'"
  sleep(1)
  puts "You ask, 'Is there a telephone I may use?'"
  sleep(1)
  puts "'Yes, of course. Come, join us.'"
  sleep(1)
end

def join_the_party
  prompt = TTY::Prompt.new
  prompt.select("Are you ready to join the party?", %w(Yes! Nope!))
end

def check_if_ready_to_play
  response = join_the_party
  if response == "Yes!"
    navigate_into_a_room
  else
    join_the_party
  end
end

def navigate_into_a_room
  prompt = TTY::Prompt.new
  prompt.keypress("Press space keys to move between rooms.", keys: [:space])
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
  if chosen_item == "Fountain Pen" || chosen_item == "Stock Pot" || chosen_item == "Feather Boa"
    ITEM_ARRAY << chosen_item
    delete_chosen_item(chosen_item)
  else
    delete_chosen_item(chosen_item)
  end
  if
    winning_array == true
    abort
  else
    if chosen_item == "Fountain Pen" || chosen_item == "Stock Pot" || chosen_item == "Feather Boa"
      puts "Hmm, this might just come in handy..."
      explore_another_room
    else
      puts "That's a nifty #{chosen_item}, but it's probably not going to help you to get out of the house. You should explore another room."
      explore_another_room
    end
  end
end

def explore_another_room
  navigate_into_a_room
  describe_a_room
  compare_items
end
# def delete item from database that you just selected

def winning_array
  if ITEM_ARRAY.length == 3
  # chosen_item = pick_an_item
  #   # binding.pry
  # if chosen_item == Item.all.sample.name
    puts "Congrats, you've picked the lock on the window with the fountain pen, jammed it open with the stock pot and scaled down with the boa!
    You escaped!"
    true
  end
end

def play_the_game
  welcome_user
  the_setup
  create_new_user
  get_asked_in
  check_if_ready_to_play
  describe_a_room
  compare_items
end

def clear_db
  Room.destroy_all
  Item.destroy_all
  ITEM_ARRAY.clear
end



play_the_game
clear_db
