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


def separator(num_of_astrsk = 24)
  $report_file.puts("*" * num_of_astrsk)
end


# Name: prnt_file
# Parameters: none
# Description: Prints the file used in $report_file
# to stdout.
# Return: none
def prnt_file
  $report_file = File.open("report.txt")
  $report_file.each do |line|
    puts "#{line}"
  end
  
end


def wrt_prod_nam(name)
  $report_file.puts(name)
end

def wrt_retail_prc(price, options = {})
  format = options[:format] || 6
  $report_file.puts("Retail Price:" + "%#{format}s" % "$" + price.to_s)
end

def wrt_total_purchs(count, options = {})
  format = options[:format] || 6
  $report_file.puts("Total Purchases:" + "%#{format}s" % count.to_s)
end

def wrt_total_sales(purchases, options = {})
  format = options[:format] || 6
  total_sales = 0.0
  purchases.each do |sale|
    total_sales += sale["price"]
  end
  $report_file.puts("Total Sales:" + "%#{format}s" % "$" + total_sales.to_s)
  total_sales
end

def wrt_avg_prc(total_sales, sales_count, options = {})
  format = options[:format] || 6
  precision = options[:precision] || 2
  avg_prc = (total_sales / sales_count).round(options[:precision])
  $report_file.puts("Average Price:" + "%#{format}s" % "$" + avg_prc.to_s)
  avg_prc
end

def wrt_avg_disc(avg_prc, retail_prc, options = {})
  format = options[:format] || 6
  precision = options[:precision] || 2

  avg_disc = ((1 - avg_prc / retail_prc.to_f) * 100.0).round(options[:precision])
  $report_file.puts("Average Discount:" + "%#{format}s" % avg_disc.to_s + "%")
end

def create_report

  # 1. Write report headers (title and section)
  wrt_rpt_hdr
  wrt_rpt_hdr(:product)
  
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

    $report_file.puts

    # 3. Collect brand info
    brands.push({title: product["brand"], stock: 0, total_prc: 0.0, total_sales: 0.0, count: 0, brand_avg_prc: 0.0})

    

    
    # 4. Keep hash array unique
    brands = brands.uniq { |item| item[:title] }
    
    brands = brands.each { |item|
      if item[:title] == product["brand"]
        item[:stock] = item[:stock] + product["stock"]
        item[:total_prc] = (item[:total_prc] + product["full-price"].to_f).round(2)
        item[:total_sales] = (item[:total_sales] + total_sales).round(2)
        item[:count] = item[:count] + 1
        item[:brand_avg_prc] = item[:total_prc] / item[:count]
      end
    }

    #puts $products_hash
    puts brands
    
  end

  
  wrt_rpt_hdr(:brand)

  $report_file.close
  
  prnt_file
end

def start
  setup_files
  create_report
end

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
