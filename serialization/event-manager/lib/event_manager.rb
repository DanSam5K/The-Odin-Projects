require "csv"
require "google/apis/civicinfo_v2"
require "erb"

def contents
  CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
end


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone_number(phone_number)
  phone_number = phone_number.to_s.gsub(/[^0-9]/, "")
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == "1"
    phone_number[1..-1]
  else
    "0000000000"
  end
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: "country",
      roles: ["legislatorUpperBody", "legislatorLowerBody"]
    ).officials
    
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end 
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")
  
  filename = "output/thanks_#{id}.html"
  
  File.open(filename, "w") do |file|
    file.puts form_letter
  end
end

def time_targeting(regdate)
  regdate = DateTime.strptime(regdate, "%m/%d/%y %H:%M")
  regdate.hour
end

def day_targeting(regdate)
  regdate = DateTime.strptime(regdate, "%m/%d/%y %H:%M")
  regdate.wday
end

def most_popular_day(file_content)
  days = Hash.new(0)
  file_content.each do |row|
    # hours[row[:regdate].split(" ")[1].split(":")[0]] += 1
    days[day_targeting(row[:regdate])] += 1
  end
  days.max_by { |k, v| v }
end


def most_popular_hour(file_content)
  hours = Hash.new(0)
  file_content.each do |row|
    # hours[row[:regdate].split(" ")[1].split(":")[0]] += 1
    hours[time_targeting(row[:regdate])] += 1
  end
  hours.max_by { |k, v| v }
end

puts "Event Manager Initialized!"

# template_letter = File.read("form_letter.html")

template_letter = File.read("form_letter.erb")
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  phone_number = clean_phone_number(row[:homephone])

  legislator_names = legislators_by_zipcode(zipcode)
  
  form_letter = erb_template.result(binding)
   
  save_thank_you_letters(id, form_letter)
end

puts "Most popular hour: #{most_popular_hour(contents)[0]} o'clock with #{most_popular_hour(contents)[1]} registrations."

puts "Most popular day: #{most_popular_day(contents)[0]} with #{most_popular_day(contents)[1]} registrations."
