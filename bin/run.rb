require_relative '../config/environment'
require "pry"
require 'colorize'

ActiveRecord::Base.logger.level = 1

ITEM_ARRAY = []

def line_break
  puts " "
end

def welcome_user
  puts "Welcome to...".colorize(:light_green)
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
puts "A text-based experience by Claudia & Matt".colorize(:light_green)
line_break
sleep(4)
end

def the_setup
  puts "You're driving through a strange town at night when your car breaks down. It's pouring rain, you suspect that you've lost your way and the only house within sight is a vast, sprawling mansion."
  line_break
  sleep(5)
  puts "The lights in every window are lit and you can see a number of people inside, so you decide to go and ask to use a telephone."
  line_break
  sleep(3)
  puts "A stranger opens the door and eyes you suspiciously."
  line_break
  sleep(2)
end

def create_new_user
  user_instance = User.create(name: nil, role: nil)
  user_instance.name = user_instance.get_user_name
  user_instance.role = user_instance.get_user_role
  user_instance.save
end

def friend
 if User.last.name.length < 2
   friend_name = "friend"
 else
   friend_name = User.last.name
 end
 friend_name
end

def get_asked_in
  line_break
  sleep(2)
  puts "The stranger shows little interest as you introduce yourself. Before you can begin to explain your plight, they interrupt you."
  line_break
  sleep(3)
  puts "'Welcome, #{friend}, please, come in. The dinner portion of our evening has just concluded, but the guests are now enjoying digestifs and coffee in the sitting room. You’ll find your hostess inside.'"
  line_break
  sleep(5)
  puts "You falter, and ask, 'Is there a telephone I may use?'"
  line_break
  sleep(2)
  puts "'Yes, of course. Come in from the rain and join us.'"
  line_break
  sleep(2)
end

  def add_char_to_room
    char = Character.all.sample
    puts "A #{char.name} is there to greet you; an unwelcome presence who says: #{char.saying}".colorize(:cyan)
    line_break
    sleep(1)
  end

def join_the_party
  prompt = TTY::Prompt.new
  answer = prompt.select("Are you ready to join the party?", ["Yes.", "Do I have a choice?"])
  if answer == "Yes."
    story
  else
    join_the_party
  end
end

def story
  line_break
  puts "You're somewhat mystified——you were clearly not invited to this dinner party——but your curiosity leads you to go in. It's not every day you get to see the inside of a mansion."
  line_break
  sleep(4)
  puts "Once inside, you're shown into a large sitting room full of people, and you scan the group for the hostess, whoever she may be. While you're peering around, the members of the party become aware of your presence."
  line_break
  sleep(6)
  puts "All conversation quickly dies out."
  line_break
  sleep(2)
  puts "You clear your throat, a chill creeping down your spine, and manage to say, 'My... my car broke down. Is there a phone I can use?'"
  line_break
  sleep(4)
  puts "All eyes are still locked on you. A man in a top hat brandishing a martini finally speaks up."
  line_break
  sleep(2)
  puts "'Perhaps there's a telephone here, although I doubt you'll be allowed to make a call. Our hostess is very particular. There are rules, you see.'"
  line_break
  sleep(4)
  puts "Your mouth is dry, you swallow. 'Rules?'"
  line_break
  sleep(2)
  puts "A young woman adorned in a multitude of pearls chimes in. 'Well, yes, of course. This is a murder mystery party, after all. We're only allowed to leave as soon as we find the murderer, and naturally there's no contact with the outside world.'"
  line_break
  sleep(6)
  puts "'So... this is a game?'"
  line_break
  sleep(2)
  puts "'It's a game of sorts,' says a stout older man with a full, white beard. 'I promise you, it's the most thrilling game you'll ever play.'"
  line_break
  sleep(4)
  puts "As you start to formulate a response, the stranger who met you at the door walks in and makes an announcement."
  line_break
  sleep(4)
  puts "'It is now 9:00. We ask you to leave the sitting room and to go explore the house. Our murderer will be roaming the rooms among us, so if you're lucky you'll join the rest of us back here in an hour to begin our detective work.'"
  line_break
  sleep(6)
  puts "The room empties out and you dash back to the door you came in through. It's locked, of course, so you try a window. That too is locked tight. In a panic, you try the windows in another room with no luck"
  line_break
  sleep(6)
  puts "By now it's clear that your only options are to play the game, or break out of here."
  line_break
  sleep(3)
  puts "It's not much of a choice. Let's not gamble with our lives tonight. There must be a way to escape!"
  line_break
  sleep(2)
  puts "Best of luck, #{friend}."
  line_break
  sleep(2)
end

def navigate_into_a_room
  prompt = TTY::Prompt.new
  answer = prompt.select("Select the direction you'd like to take:", ["↑ North", "→ East", "↓ South", "← West"])
  line_break
  sleep(1)
end

def describe_a_room
  puts "You find yourself in a #{Room.random_room} with a strange assortment of items.".colorize(:light_green)
  line_break
  sleep(1)
  add_char_to_room
  sleep(1)
end

def pick_an_item
  prompt = TTY::Prompt.new
  prompt.select("Please pick only one. Choose wisely:", Item.list_of_random_items)
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
    winning_array
  elsif chosen_item == "Fountain Pen" || chosen_item == "Stock Pot" || chosen_item == "Feather Boa"
    while ITEM_ARRAY.length < 3
      line_break
      puts "Hmmm, this might just come in handy..."
      line_break
      sleep(1)
      explore_another_room
    end
    else
    line_break
    puts "That's a nifty #{chosen_item}, but it's probably not going to help you to get out of the house. You should explore another room."
    line_break
    sleep(1)
    explore_another_room
  end
end

def explore_another_room
  navigate_into_a_room
  describe_a_room
  compare_items
end

def winning_array
  if ITEM_ARRAY.length == 3
    line_break
    puts "You get to a window without anyone noticing and pick the lock with your "+"fountain pen".colorize(:light_green)+". Then you jam the window open with the "+"stock pot".colorize(:light_green)+", tie your "+"feather boa".colorize(:light_green)+" to a radiator and use it to climb down and drop safely into a large boxwood shrub."
    line_break
    sleep(5)
    puts "You’re a little scratched up and shaken, but you’ve made it out "+"alive".colorize(:light_green)+"."
    line_break
    sleep(3)
    puts "Congratulations, you’ve successfully escaped The Dinner Party! That was... pretty weird."
  end
end

def clear_db
  Room.destroy_all
  Item.destroy_all
  ITEM_ARRAY.clear
end

def play_the_game
  welcome_user
  the_setup
  create_new_user
  get_asked_in
  join_the_party
  navigate_into_a_room
  describe_a_room
  compare_items
end

play_the_game
clear_db
