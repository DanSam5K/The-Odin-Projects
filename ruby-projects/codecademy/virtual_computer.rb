class Computer
  @@users = {}
  def initialize(username, password)
    @username = username
    @password = password
    @files = {}

    @@users[username] = password
  end

  def create(filename)
    time = Time.now()
    @files[filename] = time
    puts "#{filename} was sucessfully created for #{@username}"
  end

  def Computer.get_users
    @@users
  end

  def get_files
    @files
  end

  def delete_files(filename)
   @files.delete(filename) unless @files == nil
  end

  def update_files(name, new_value)
    @files[name] = new_value
  end
end

my_computer = Computer.new("Daniel", "12345")
puts Computer.get_users

my_computer.create("Food.txt")
my_computer.create("Power")

p my_computer.get_files
p my_computer.delete_files("Power")
p my_computer.get_files
my_computer.update_files("Food.txt", "Greatness")

p my_computer.get_files

