require 'json'

def setup_files
  path = File.join(File.dirname(__FILE__), '../data/products.json')
  file = File.read(path)
  $products_hash = JSON.parse(file)
  $report_file = File.new("report.txt", "w+")
end

def wrt_rpt_hdr(heading = :title)
  if heading == :title
    $report_file.write(" #####                                 ######"+ "\r\n")
    $report_file.write("#     #   ##   #      ######  ####     #     # ###### #####   ####  #####  #####"+ "\r\n")
    $report_file.write("#        #  #  #      #      #         #     # #      #    # #    # #    #   #" + "\r\n")
    $report_file.write(" #####  #    # #      #####   ####     ######  #####  #    # #    # #    #   #" + "\r\n")
    $report_file.write("      # ###### #      #           #    #   #   #      #####  #    # #####    #" + "\r\n")
    $report_file.write("#     # #    # #      #      #    #    #    #  #      #      #    # #   #    #" + "\r\n")
    $report_file.write(" #####  #    # ###### ######  ####     #     # ###### #       ####  #    #   #" + "\r\n")
    $report_file.write("********************************************************************************" +"\r\n")
    $report_file.write("\r\n")

    # Write the current date to the report file
    $report_file.write(Time.now.strftime("%m/%d/%Y") + "\r\n")
  end
  if heading == :product
    $report_file.write("                     _            _"+ "\r\n")
    $report_file.write("                    | |          | |"+ "\r\n")
    $report_file.write(" _ __  _ __ ___   __| |_   _  ___| |_ ___"+ "\r\n")
    $report_file.write("| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"+ "\r\n")
    $report_file.write("| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\" + "\r\n")
    $report_file.write("| ,__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/" + "\r\n")
    $report_file.write("| |                                       " + "\r\n")
    $report_file.write("|_|" + "\r\n")
    $report_file.write("************************" + "\r\n")
    $report_file.write("\r\n")
  end
  if heading == :brand
    $report_file.write(" _                         _" + "\r\n")
    $report_file.write("| |                       | |" + "\r\n")
    $report_file.write("| |__  _ __ __ _ _ __   __| |___" + "\r\n")
    $report_file.write("| '_ \\| '__/ _` | '_ \\ / _` / __|" + "\r\n")
    $report_file.write("| |_) | | | (_| | | | | (_| \\__ \\" + "\r\n")
    $report_file.write("|_.__/|_|  \\__,_|_| |_|\\__,_|___/" + "\r\n")
    $report_file.write("\r\n")
  end
end

def prnt_file
  $report_file = File.open("report.txt")
  $report_file.each do |line|
    puts "#{line}"
  end
  
end


def create_report

  # 1. Write report headers (title and section)
  wrt_rpt_hdr
  wrt_rpt_hdr(:product)
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
