class TodoList
  attr_accessor :title, :items
  # methods and stuff go here

  # Initialize todo list with a title and no items
  def initialize(list_title)
    @title = list_title
    @items = Array.new # Starts empty! No Items yet!
  end

  # Note: This method is not necessary
  # due to accessor allowing array methods
  # to be performed on items. However
  # this method was desired per spec
  def add_item(new_item)
    item = Item.new(new_item)
    @items.push(item)
  end

  # Note: This method is not necessary
  # due to accessor allowing array methods
  # to be performed on items. However
  # this method was desired per spec
  def delete_item(del_item)
    @items.delete(del_item) {"item not found"}
  end

  def delete_item(index)
    @items.delete_at(index)
  end

  def sort_priority
    @items.sort { |x, y| y.priority[:value] <=> x.priority[:value] }
  end

  def sort_priority!
    @items.sort! { |x, y| y.priority[:value] <=> x.priority[:value] }
  end

  # Searches the list based on description, completed/incomplete
  # searches are possible. Returns items that match search input.
  def search_description(target)
    results = []
    @items.each do |item|
      if item.description.include?(target)
        results.push(item)
      end
    end
    results
  end

  def search_completion(target = true)
    results = []
    @items.each do |item|
      if item.completed_status == target
        results.push(item)
      end
    end
    results
  end

  def search_priority(target = Priority::LOW)
    results = []
    @items.each do |item|
      if item.priority == target
        results.push(item)
      end
    end
    results
  end

  def print_list opts = {}
    options = {num: @title.length, char: "*", newline: "\n"}.merge(opts)

    #print title
    output = options[:char] * options[:num]
    output += options[:newline]
    output += @title
    output += options[:newline]
    output += options[:char] * options[:num]
    output += options[:newline]
    output += options[:newline]

    #print items
    @items.each do |item|
      output += sprintf "%-5d", (@items.index(item) + 1)
      output += item.print_item
      output += options[:newline]
    end

    output
  end
end

class Item
  attr_accessor :description, :completed_status, :priority
  # methods and stuff go here

  # Initialize item with a description and marked as
  # not complete
  def initialize(item_description)
    @description = item_description
    @completed_status = false
    @priority = Priority::LOW
  end

  def update_completion
    @completed_status = @completed_status ? false : true
  end

  def completed?
    @completed_status
  end
  
  def escalate_priority
    if @priority == Priority::HIGH
      return # can't go any higher
    elsif @priority == Priority::MEDIUM
      @priority = Priority::HIGH
    elsif @priority == Priority::LOW
      @priority = Priority::MEDIUM
    else
      return
    end
  end

  def descalate_priority
    if @priority == Priority::HIGH
      @priority = Priority::MEDIUM
    elsif @priority == Priority::MEDIUM
      @priority = Priority::LOW
    elsif @priority == Priority::LOW
      return # can't go any lower
    else
      return
    end
  end

  def print_item
    output = sprintf "%-20s", @description
    output += sprintf "%-20s", "Completed: " + @completed_status.to_s
    output += sprintf "%-20s", "Priority: " + @priority[:string]
    output
  end
    
end

# New feature - list priority
class Priority
  LOW={value: 1, string: "Low"}
  MEDIUM={value: 2, string: "Medium"}
  HIGH={value: 3, string: "High"}
end


