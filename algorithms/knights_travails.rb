class Knight
  attr_accessor :position, :parent, :children

  def initialize(position, parent = nil)
    @position = position
    @parent = parent
    @children = []
  end

  def to_s
    @position.to_s
  end

  def add_child(child)
    @children << child
  end

  def find_path
    path = []
    current = self
    while current
      path << current.position
      current = current.parent
    end
    path.reverse
  end
end
