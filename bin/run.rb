require_relative '../config/environment'
require "pry"

def welcome_user
  puts "Welcome to the Dinner Party!"
end

def create_new_user
  user_instance = User.create(name: nil, role: nil)
  user_instance.name = user_instance.get_user_name
  user_instance.role = user_instance.get_user_role
  user_instance.save
end


welcome_user
create_new_user


# get_user_name #prompt user for name input, gets name from user
# update_user_name # sets @name == user input
# get_user_role #prompt user to select one of X roles, gets role from user and accepts only X inputs
# invalid_input #puts out error message
# update_user_role # sets @role == user input
# tutorial #explains acceptable input, how the gameplay works, lays out the ultimate goal
# enter room #initialize room with items, character
# describe_room #puts out room, character and items info
