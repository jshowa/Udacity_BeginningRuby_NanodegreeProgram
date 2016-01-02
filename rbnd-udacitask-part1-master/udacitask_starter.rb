require './todolist.rb'

# Creates a new todo list
todolist = TodoList.new("Jacob's Todo List")

# Add four new items
todolist.add_item("Go to store")
todolist.add_item("Finish homework")
todolist.add_item("Wash dishes")
todolist.add_item("Clean house")

# Print the list
puts todolist.print_list
puts 

# Delete the first item
todolist.delete_item(0)

# Print the list
puts todolist.print_list
puts

# Delete the second item
todolist.delete_item(1)

# Print the list
puts todolist.print_list
puts
# Update the completion status of the first item to complete
todolist.items[0].update_completion

# Print the list
puts todolist.print_list
puts
# Update the title of the list
todolist.title = "Jacob's New Todo List"

# Print the list
puts todolist.print_list
puts
