class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next = node
      @tail = node
    end
  end

  def prepend(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
      @tail = node
    else
      node.next = @head
      @head = node
    end
  end

  def size
    count = 0
    current = @head
    while current
      count += 1
      current = current.next
    end
    count
  end

  def head
    @head.value
  end

  def tail
    @tail.value
  end

  def at(index)
    current = @head
    index.times do
      current = current.next
    end
    current.value if current
  end

  def pop
    current = @head
    while current.next != @tail
      current = current.next
    end
    current.next = nil
    @tail = current
  end

  def contains?(value)
    current = @head
    while current
      return true if current.value == value
      current = current.next
    end
    false
  end

  def find(value)
    current = @head
    index = 0
    while current
      return index if current.value == value
      current = current.next
      index += 1
    end
    nil
  end

  def to_s
    current = @head
    string = ""
    while current
      string += "( #{current.value} ) -> "
      current = current.next
    end
    string += "nil"
  end

  def insert_at(value, index)
    current = @head
    index.times do
      current = current.next
    end
    node = Node.new(value)
    node.next = current.next
    current.next = node
  end

  def remove_at(index)
    current = @head
    (index - 1).times do
      current = current.next
    end
    current.next = current.next.next
  end

end

class Node
  attr_accessor :value, :next
  def initialize(value = nil, next_node = nil)
    @value = value
    @next = next_node
  end
end

list = LinkedList.new
list.append(5)
list.prepend(8)

list.append(10)
list.append(15)
list.append(20)
list.append(25)

p list.insert_at(12, 2).to_s
p list.remove_at(3).to_s

p list.at(1)


p list.to_s
