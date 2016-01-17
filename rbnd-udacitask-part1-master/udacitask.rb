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
todolist.add_item("Go to store")

puts "************TESTING NEW FEATURES***************"
puts "************TESTING FEATURE ONE****************"
puts

# Feature 1 - priority setting and sorting (new/in place)
todolist.items[0].priority = Priority::HIGH
todolist.items[1].priority = Priority::LOW
todolist.items[2].priority = Priority::MEDIUM
todolist.items[3].priority = Priority::HIGH

puts "************PRIORITY SORT (HIGH TO LOW)********"
puts

priority_list = todolist.sort_priority

priority_list.each do |item|
  puts item.print_item
end
puts

puts "************PRIORITY SORT (IN PLACE)***********"
puts

todolist.sort_priority!
puts todolist.print_list
puts

puts "************TESTING NEW FEATURES***************"
puts "************TESTING FEATURE TWO****************"
puts

# Feature 2 - Search description, priority, completion

puts "************SEARCH DESCRIPTION (GO)************"
puts

search_results = todolist.search_description("Go")

search_results.each do |item|
  puts item.print_item
end
puts

puts "************SEARCH COMPLETION (TRUE)**********"
puts

search_results = todolist.search_completion

search_results.each do |item|
  puts item.print_item
end
puts

puts "************SEARCH PRIORITY (HIGH)************"
puts

search_results = todolist.search_priority(Priority::HIGH)

search_results.each do |item|
  puts item.print_item
end
puts

puts "************TESTING NEW FEATURES*****************"
puts "************TESTING FEATURE THREE****************"
puts

puts "*****WRITING LIST TO FILE (UDACITASK.TXT)********"
puts
# Feature 3 - Write to file/read from file
todolist.wrt_list_to_file("udacitask.txt")

puts "*****READING LIST FROM FILE (UDACITASK.TXT)******"
puts

todolist.rd_list_file("udacitask.txt")
