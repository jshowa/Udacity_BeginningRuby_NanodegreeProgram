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

# New features
todolist.add_item("Go to school")

# Feature 1 - priority setting and sorting (new/in place)
todolist.items[0].priority = Priority::HIGH
todolist.items[1].priority = Priority::LOW
todolist.items[2].priority = Priority::MEDIUM
todolist.items[3].priority = Priority::HIGH

priority_list = todolist.sort_priority

priority_list.each do |item|
  puts item.print_item
end
puts

todolist.sort_priority!
puts todolist.print_list
puts

# Feature 2 - Search description, priority, completion
search_results = todolist.search("Go")

search_results.each do |item|
  puts item.print_item
end

# Feature 3 - Write to file/read from file
