# Required libraries for the script to work
require 'nokogiri'  # For HTML parsing
require 'open-uri'  # For opening URLs
require 'csv'       # For handling CSV files

# Array to store hospital names
hospitals = []

# URL of the site to parse
url = 'https://www.hospitalsafetygrade.org/all-hospitals'

# Use Nokogiri to parse the HTML content of the website
doc = Nokogiri::HTML(URI.open(url))

# Extract hospital names from the specific CSS selector
doc.css('div#BlinkDBContent_849210 ul li a').each do |hospital|
  hospitals << hospital.text.strip
end

# Write the extracted data to a CSV file
CSV.open('hospitals.csv', 'w') do |csv|

  # Write header row
  csv << ['ID', 'HOSPITAL NAME']

  # Assign a unique ID to each hospital and write to CSV
  id = 1
  hospitals.each do |hospital|
    csv << [id, hospital]
    id += 1
  end
end

# Print success messages
puts "Parsing of website #{url} was performed"
puts "Data successfully saved to hospitals.csv"
