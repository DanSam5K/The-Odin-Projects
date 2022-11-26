class Node
  include Comparable

  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    array = array.uniq.sort
    mid = array.length / 2
    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid + 1..-1])
    root
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left
  end

end

tree = Tree.new([1, 7, 4, 23, 8, 9, 3, 5, 6, 2, 1, 7, 4, 23, 8, 9, 3, 5, 6, 2])
p tree.build_tree([1, 7, 4, 23, 8, 9, 3, 5, 6, 2, 1, 7, 4, 23, 8, 9, 3, 5, 6, 2])

tree.pretty_print