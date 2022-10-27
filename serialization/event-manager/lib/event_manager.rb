puts "Event Manager Initialized!"


contents = File.read('event_attendees.csv')
p contents[3]

lines = File.readlines("event_attendees.csv")
lines.each do |line|
  next if line == lines[0]
  columns = line.split(",")
  name = columns[2]
  puts name
end