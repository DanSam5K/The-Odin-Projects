class LinkedList
  attr_accessor :head, :tail

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
list.append(6)
list.prepend(6)
list.prepend(7)
list.prepend(8)

p list.tail.value
p list.head.value

p list.size
