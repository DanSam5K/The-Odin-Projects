require "csv"
require "google/apis/civicinfo_v2"
require "erb"


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

puts "Event Manager Initialized!"

# template_letter = File.read("form_letter.html")

contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)

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