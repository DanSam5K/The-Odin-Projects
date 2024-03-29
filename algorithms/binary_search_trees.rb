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

  def insert(value, node = root)
    return Node.new(value) if node.nil?

    if value < node.value
      node.left = insert(value, node.left)
    elsif value > node.value
      node.right = insert(value, node.right)
    end
    node
  end

  def delete(value, node = root)
    return node if node.nil?

    if value < node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      temp = node
      node = min_value(temp.right)
      node.right = delete_min(temp.right)
      node.left = temp.left
    end
    node
  end

  def find(value, node = root)
    return node if node.nil? || node.value == value

    if value < node.value
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order(node = root)
    return nil if node.nil?

    queue = [node]
    result = []
    while queue.length.positive?
      current = queue.shift
      result << current.value
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
    end
    result
  end

  def inorder(node = root, result = [])
    return result if node.nil?

    inorder(node.left, result)
    result << node.value
    inorder(node.right, result)

    result
  end

  def preorder(node = root, result = [])
    return result if node.nil?

    result << node.value
    preorder(node.left, result)
    preorder(node.right, result)

    result
  end

  def postorder(node = root, result = [])
    return result if node.nil?

    postorder(node.left, result)
    postorder(node.right, result)
    result << node.value

    result
  end

  def height(node = root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    left_height > right_height ? left_height + 1 : right_height + 1
  end

  def depth(node, current = root, level = 0)
    return level if node == current || current.nil?

    if node.value < current.value
      depth(node, current.left, level + 1)
    else
      depth(node, current.right, level + 1)
    end
  end

  def balanced?(node = root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    return false if (left_height - right_height).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    @root = build_tree(level_order)
  end

  def min_value(node)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def delete_min(node)
    return node.right if node.left.nil?

    node.left = delete_min(node.left)
    node
  end
end

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print

puts "Level order: #{tree.level_order}"
puts "Inorder: #{tree.inorder}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"

puts "Height: #{tree.height}"
puts "Depth: #{tree.depth(tree.find(50))}"
puts "Balanced?: #{tree.balanced?}"


