require 'json'

# Name: setup_files
# Parameters: none
# Description: Parses a json file into a hash and creates a new file
# Return: none
def setup_files
  path = File.join(File.dirname(__FILE__), '../data/products.json')
  file = File.read(path)
  $products_hash = JSON.parse(file)
  $report_file = File.new("report.txt", "w+")
end

# Name: wrt_rpt_hdr
# Parameters: symbol heading - default :title
# Description: Writes a heading to the file $report_file based on
# heading. Valid options are title, product, and brand. The report
# title is printed as the default.
# Return: none
def wrt_rpt_hdr(heading = :title)
  if heading == :title
    $report_file.puts(" #####                                 ######")
    $report_file.puts("#     #   ##   #      ######  ####     #     # ###### #####   ####  #####  #####")
    $report_file.puts("#        #  #  #      #      #         #     # #      #    # #    # #    #   #")
    $report_file.puts(" #####  #    # #      #####   ####     ######  #####  #    # #    # #    #   #")
    $report_file.puts("      # ###### #      #           #    #   #   #      #####  #    # #####    #")
    $report_file.puts("#     # #    # #      #      #    #    #    #  #      #      #    # #   #    #")
    $report_file.puts(" #####  #    # ###### ######  ####     #     # ###### #       ####  #    #   #")
    $report_file.puts("********************************************************************************")
    $report_file.puts

    # Write the current date to the report file
    $report_file.puts(Time.now.strftime("%m/%d/%Y"))
  end
  if heading == :product
    $report_file.puts("                     _            _")
    $report_file.puts("                    | |          | |")
    $report_file.puts(" _ __  _ __ ___   __| |_   _  ___| |_ ___")
    $report_file.puts("| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|")
    $report_file.puts("| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\")
    $report_file.puts("| ,__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/")
    $report_file.puts("| |                                       ")
    $report_file.puts("|_|")
    $report_file.puts("************************")
    $report_file.puts
  end
  if heading == :brand
    $report_file.puts(" _                         _")
    $report_file.puts("| |                       | |")
    $report_file.puts("| |__  _ __ __ _ _ __   __| |___")
    $report_file.puts("| '_ \\| '__/ _` | '_ \\ / _` / __|")
    $report_file.puts("| |_) | | | (_| | | | | (_| \\__ \\")
    $report_file.puts("|_.__/|_|  \\__,_|_| |_|\\__,_|___/")
    $report_file.puts
  end
end


# Name: separator
# Parameters: integer num_of_astrsk - default 24
# Description: Writes a section divider between
# each item in the report file. The section divider is
# multiple asterisk characters with the default
# being 24.
# Return: none
def separator(num_of_astrsk = 24)
  $report_file.puts("*" * num_of_astrsk)
end


# Name: prnt_file (testing only)
# Parameters: none
# Description: Prints the file used in $report_file
# to stdout.
# Return: none
#def prnt_file
#  $report_file = File.open("report.txt")
#  $report_file.each do |line|
#    puts "#{line}"
#  end
#  
#end


# Name: wrt_prod_name
# Parameters: name - name of product
# Description: Writes the name of the product
# to the report file.
# Return: none
def wrt_prod_nam(name)
  $report_file.puts(name)
end

# Name: wrt_retail_prc
# Parameters: price - product retail price, symbol format - field spacing
# Description: Writes the products retail price to the report file.
# Return: none
def wrt_retail_prc(price, options = {})
  format = options[:format] || 6
  $report_file.puts("Retail Price:" + "%#{format}s" % "$" + price.to_s)
end

# Name: wrt_total_purchs
# Parameters: count - number of purchases for a product, symbol format - field spacing
# Description: Writes the number of purchases for a productn to the report file.
# Return: none
def wrt_total_purchs(count, options = {})
  format = options[:format] || 6
  $report_file.puts("Total Purchases:" + "%#{format}s" % count.to_s)
end

# Name: wrt_total_sales
# Parameters: purchases - purchase information for a product, symbol format - field spacing
# Description: Calculates and writes the total sales for the product to the report.
# Return: total_sales - total amount of sales for the product based on purchases
def wrt_total_sales(purchases, options = {})
  format = options[:format] || 6
  total_sales = 0.0
  purchases.each do |sale|
    total_sales += sale["price"]
  end
  $report_file.puts("Total Sales:" + "%#{format}s" % "$" + total_sales.to_s)
  total_sales
end

# Name: wrt_avg_prc
# Parameters: total_sales - total sales amount for product, sales_count - # of purchases for product
# symbol format - field spacing, symbol precision - digits to round 
# Description: Calculates average price of product to two digits after the decimal and writes
# it to the report file.
# Return: avg_prc - average sale price of the product 
def wrt_avg_prc(total_sales, sales_count, options = {})
  format = options[:format] || 6
  precision = options[:precision] || 2
  avg_prc = (total_sales / sales_count).round(options[:precision])
  $report_file.puts("Average Price:" + "%#{format}s" % "$" + avg_prc.to_s)
  avg_prc
end

# Name: wrt_avg_disc
# Parameters: avg_prc - average sales price of the product, retail_prc - regular price the product is sold at
# symbol format - field spacing, symbol precision - digits to round
# Description: Calculates the average discount to two digits after the decimal and writes it
# to the report file. The formula is based on the difference of the average price and full retail price
# compared to the full retail price.
# Return: none
def wrt_avg_disc(avg_prc, retail_prc, options = {})
  format = options[:format] || 6
  precision = options[:precision] || 2

  avg_disc = ((1 - avg_prc / retail_prc.to_f) * 100.0).round(options[:precision])
  $report_file.puts("Average Discount:" + "%#{format}s" % avg_disc.to_s + "%")
end

# Name: add_new_brand
# Parameters: brands - array containing product brands info, symbol product_brand - optional argument for brand name
# Description: Adds a new brand with default stock, total price, total sales, count and average price (defaulted
# to 0) and brand title passed as optional argument. The additions are unique based on the brand name.
# Return: none
def add_new_brand(brands, options = {})
  product_brand = options[:product_brand] || "" 
  brands.push({title: product_brand, stock: 0, total_prc: 0.0, total_sales: 0.0, count: 0, brand_avg_prc: 0.0})
  brands = brands.uniq! { |item| item[:title] }
end

# Name: add_brand_info
# Parameters: brands - array containing product brands info, title - brand name of product, stock - # products
# in stock with that brand, full_prc - total retail price of all products within the brand, total_sales - total
# sales of all products within the brand, (optional args) symbol full_prc_precision - # digits to round total retail price of
# all products within the brand, symbol tot_sales_precision - # of digits to round total sales of all products
# within the brand, symbol avg_prc_precision - # of digits to round average brand price
# Description: Adds the stock of products in the brand, total retail price of all products in the brand,
# total sales of all products in the brand, and the average price of all products in the brand to the
# brands array based on the brand name.
# Return: none
def add_brand_info(brands, title = "", stock = 0, full_prc = 0.0, total_sales = 0.0, options = {})
  brands.each { |item|
    if item[:title] == title
      add_brand_stk(item, stock)
      add_brand_tot_prc(item, full_prc, precision: options[:full_prc_precision] || 2)
      add_brand_tot_sales(item, total_sales, precision: options[:tot_sales_precision] || 2)
      add_brand_avg_prc(item, precision: options[:avg_prc_precision] || 2)
    end
  }

end

# Name: add_brand_stk
# Parameters: brand_hash - hash for specific brand, stock - stock of specific product
# Description: Adds stock of product to existing brand
# Return: none
def add_brand_stk(brand_hash, stock = 0)
  brand_hash[:stock] = brand_hash[:stock] + stock
end

# Name: add_brand_tot_prc
# Parameters: brand_hash - hash for specific brand, full_prc - retail price
# of product, (optional) precision - # of digits to round total retail price of products in brand
# Description: Adds retail price of product to existing brand
# Return: none
def add_brand_tot_prc(brand_hash, full_prc = 0.0, options = {})
  brand_hash[:total_prc] = (brand_hash[:total_prc] + full_prc.to_f).round(options[:precision] || 2)
end

# Name: add_brand_tot_sales
# Parameters: brand_hash - hash for specific brand, total_sales - total sales 
# of products in brand, (optional) precision - # of digits to round total sales of products in brand
# Description: Adds totals sales of each product to existing brand
# Return: none
def add_brand_tot_sales(brand_hash, total_sales = 0.0, options = {})
  brand_hash[:total_sales] = (brand_hash[:total_sales] + total_sales).round(options[:precision] || 2)
end

# Name: add_brand_avg_prc
# Parameters: brand_hash - hash for specific brand, 
# Description: Counts each product in existing brand and takes the average price
# over the sum of the retail prices of each product in the brand. (optional) precision - # of digits
# to round total sales of products in brand
# Return: none
def add_brand_avg_prc(brand_hash, options = {})
  brand_hash[:count] = brand_hash[:count] + 1
  brand_hash[:brand_avg_prc] = (brand_hash[:total_prc] / brand_hash[:count]).round(options[:precision] || 2)
end

# Name: wrt_brand_info
# Parameters: brands - array containing brand info, boolean nam_flg - flag used
# to write the brand name (default = true), boolean stk_flg - flag used to write the
# stock of each brand (default = true), boolean avg_prc_flg - flag used to write the
# average retail price of products in the brand (default = true), boolean tot_sales_flg -
# flag used to write the total sales of each product in the brand (default = true), (optional) symbol
# stk_format - character spacing for writing brand stock, symbol brand_avg_prc_format - 
# character spacing for writing brand average retail price, symbol brand_tot_sales_format -
# character spacing for writing brand total sales
# Description: Writes brand information to report file based on parameter flags.
# Return: none
def wrt_brand_info(brands, nam_flg = true, stk_flg = true, avg_prc_flg = true, tot_sales_flg = true, options = {})
  brands.each { |item|
    if nam_flg
      wrt_brand_name(item[:title])
      separator(29)
    end
    if stk_flg
      wrt_brand_stk(item[:stock], options[:stk_format])
    end
    if avg_prc_flg
      wrt_brand_avg_prc(item[:brand_avg_prc], options[:brand_avg_prc_format])
    end
    if tot_sales_flg
      wrt_brand_tot_sales(item[:total_sales], options[:brand_tot_sales_format])
    end
    separator(29)
    $report_file.puts
  }
end

# Name: wrt_brand_name
# Parameters: title - brand name 
# Description: Writes the name of the brand in upper case letters
# to the report file.
# Return: none
def wrt_brand_name(title)
  $report_file.puts(title.upcase)
end

# Name: wrt_brand_stk
# Parameters: stock - # of products available, format - character spacing for stock (default = 6) 
# Description: Writes the stock available for the brand to the report file
# Return: none
def wrt_brand_stk(stock, format = 6)
  $report_file.puts("Number of Products:" + "%#{format}s" % stock.to_s)
end

# Name: wrt_brand_avg_prc
# Parameters: brand_avg_prc - retail price of all products for the brand, format - character spacing for stock (default = 6)
# Description: Writes the average retail price across all products for the specific brand to the
# report file.
# Return: none
def wrt_brand_avg_prc(brand_avg_prc, format = 6)
  $report_file.puts("Average Product Price:" + "%#{format}s" % "$" + brand_avg_prc.to_s)
end

# Name: wrt_brand_tot_sales
# Parameters: brand_tot_sales - total sales of all products for the brand, format - character spacing for stock (default = 6) 
# Description: Writes the total sales for all products in the brand to the report file.
# Return: none
def wrt_brand_tot_sales(brand_tot_sales, format = 6)
  $report_file.puts("Total Sales:" + "%#{format}s" % "$" + brand_tot_sales.to_s)
end

# Name: create_report
# Parameters: None
# Description: Required method that acts as a driver method to write
# the required content of the report.
# Return: None
def create_report

  # 1. Write report headers (title and section)
  wrt_rpt_hdr
  wrt_rpt_hdr(:product)
  
  # Array used to hold required brand info for each item.
  brands = []

  $products_hash["items"].each do |product|

    # 2. Write product name to file
    wrt_prod_nam(product["title"])

    separator

    # 2a. Write retail price
    wrt_retail_prc(product["full-price"], format: 6)

    # 2b. Write total purchases
    wrt_total_purchs(product["purchases"].length, format: 3)

    # 2c. Write total sales
    total_sales = wrt_total_sales(product["purchases"], format: 7)

    # 2d. Write average price
    avg_prc = wrt_avg_prc(total_sales, product["purchases"].length, format: 5, precision: 2)

    # 2e. Write average discount
    wrt_avg_disc(avg_prc, product["full-price"], format: 6, precision: 2)

    separator

    $report_file.puts

    # 3. Add new brand to brands array
    add_new_brand(brands, product_brand: product["brand"])

    add_brand_info(brands, product["brand"], product["stock"], product["full-price"], total_sales)

  end

  # 4. Write brand header
  wrt_rpt_hdr(:brand)

  separator(29)

  # 5. Write brand info
  wrt_brand_info(brands, true, true, true, true, stk_format: 7, brand_avg_prc_format: 2, brand_tot_sales_format: 12)


  $report_file.close
  
  #prnt_file
end

# Name: start
# Parameters: None
# Description: Driver method for report, setups JSON file and creates report
# from JSON data.
# Return: None
def start
  setup_files
  create_report
end

# Call driver method
start


# Print "Sales Report" in ascii art

# Print today's date

# Print "Products" in ascii art

# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
  # Calcalate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount based off the average sales price

# Print "Brands" in ascii art

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
