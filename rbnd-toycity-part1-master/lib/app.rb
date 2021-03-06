require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
date = Time.now.strftime("%m/%d/%Y")
puts date

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
    # Print the name of the toy
    # Print the retail price of the toy
    # Calculate and print the total number of purchases
  # Calcalate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount based off the average sales price
separator = "*" * 24

products_hash["items"].each do |product|
  total_sales = 0.0
  total_discount = 0.0

  # Print product title
  puts product["title"]

  # Print separator line
  puts separator

  # Print retail price
  puts "Retail Price:" + "%6s" % "$" + product["full-price"]

  # Print total purchases
  puts "Total Purchases:" + "%3d" % product["purchases"].length

  # Print total sales by accessing the price key in purchases array
  # add the price value for each sale to total_sales and add the discount
  # from retail from each purchase to get discount total
  product["purchases"].each do |sale|
    total_sales += sale["price"]
    total_discount += (product["full-price"].to_f - sale["price"]) / product["full-price"].to_f
  end
  puts "Total Sales:" + "%7s" % "$" + total_sales.to_s

  # Use calculated total sales divide by length of purchases array to get avg price
  average_price = (total_sales / product["purchases"].length)
  puts "Average Price:" + "%5s" % "$" + average_price.to_s

  # Divide the average price by the full price and multiply by 100 to get the discount %
  average_discount = (total_discount / product["purchases"].length * 100.0).round(2)
  puts "Average Discount:" + "%6s" % average_discount.to_s + "%" 
  
  puts separator
  puts 
end  



	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
    # Print the name of the brand
    # Count and print the number of the brand's toys we stock
    # Calculate and print the average price of the brand's toys
    # Calculate and print the total sales volume of all the brand's toys combined
        
# For each product, acquire its brand and place in array
        separator = "*" * 29
        
        brands = []
        brands_uniq = []

# begin experimental code
#        lego = "LEGO"
#        brand = "NANO BLOCK"
#        products_hash["items"].each do |product|

#          product['brand'] == "LEGO" ? brand = lego : brand = nano_block

#          brand[:count] += 1

#          brand[:price_sum] += product["full-price"].to_f

#          brand[:sales] += product['purchases'].inject(0) do |sum, el|

#            sum + el["price"]
#          end

#          puts brand

#        end
# end experimental code        
        products_hash["items"].each do |product|
          brands.push(product["brand"])
        end

        # create an array with unique brands, use this as basis for outer loop

        brands_uniq = brands.uniq

        # It was mentioned to use brand[:count] += 1 here in an each block
        # I'm not exactly sure what that means, could you elaborate more?
        i = 0
        while i < brands_uniq.length

          puts brands_uniq[i].upcase

          puts separator

          # select the first brand
          brand = products_hash["items"].select do |product|
            product["brand"] == brands_uniq[i]
          end

          # Add the inventory stock for each product that matches the brand
          brand_stock = 0
          
          brand.each do |product|
            brand_stock += product["stock"]
          end
          
          puts "Number of Products:" + "%7d" % brand_stock

          # get average price by adding full price of each product in brand
          # , then divide by how many products are in the brand
          brand_avg_price = 0

          brand.each do |product|
            brand_avg_price += product["full-price"].to_f
          end

          brand_avg_price = (brand_avg_price / brand.length).round(2)
          
          puts "Average Product Price:" + "%2s" % "$" + brand_avg_price.to_s

          # get brand total sales by accessing each product in the brands purchases
          # and adding all the price values for those purchases
          brand_total_sales = 0
          
          brand.each do |purchase|
            purchase["purchases"].each do |sale|
              brand_total_sales += sale["price"]
            end
          end

          brand_total_sales = brand_total_sales.round(2)

          puts "Total Sales:" + "%12s" % "$" + brand_total_sales.to_s
          puts # add spacing

          
          # move to the next brand
          i = i + 1
        end

          
