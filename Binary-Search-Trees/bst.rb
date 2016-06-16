###############################################################################
# *****************************************************************************
# BINARY SEARCH TREE NODE
# *****************************************************************************
###############################################################################

class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  # ***************************************************************************
  # INITIALIZE
  # ***************************************************************************

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

###############################################################################
# *****************************************************************************
# BINARY SEARCH TREE
# *****************************************************************************
###############################################################################

class BinarySearchTree

  # ***************************************************************************
  # INITIALIZE
  # ***************************************************************************

  def initialize
    @root = nil
  end

  # ***************************************************************************
  # INSERT
  # ***************************************************************************

  def insert(value)
    if !@root
      @root = BSTNode.new(value)
      return
    end

    BinarySearchTree.insert!(@root, value)
  end

  # ***************************************************************************
  # FIND
  # ***************************************************************************

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  # ***************************************************************************
  # IN ORDER
  # ***************************************************************************

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  # ***************************************************************************
  # POST ORDER
  # ***************************************************************************

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  # ***************************************************************************
  # PRE-ORDER
  # ***************************************************************************

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  # ***************************************************************************
  # HEIGHT
  # ***************************************************************************

  def height
    BinarySearchTree.height!(@root)
  end

  # ***************************************************************************
  # MIN
  # ***************************************************************************

  def min
    BinarySearchTree.min(@root)
  end

  # ***************************************************************************
  # MAX
  # ***************************************************************************

  def max
    BinarySearchTree.max(@root)
  end

  # ***************************************************************************
  # DELETE
  # ***************************************************************************

  def delete(value)
    @root = BinarySearchTree.delete!(@root, value)
  end

  # ***************************************************************************
  # INSERT
  # ***************************************************************************

  def self.insert!(node, value)
    return BSTNode.new(value) unless node

    if value <= node.value
      node.left = BinarySearchTree.insert!(node.left, value)
    else
      node.right = BinarySearchTree.insert!(node.right, value)
    end

    node
  end

  # ***************************************************************************
  # FIND
  # ***************************************************************************

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value

    if value < node.value
      return BinarySearchTree.find!(node.left, value)
    end

    BinarySearchTree.find!(node.right, value)
  end

  # ***************************************************************************
  # PRE ORDER
  # ***************************************************************************

  def self.preorder!(node)
    return [] unless node

    arr = [node.value]
    arr += BinarySearchTree.preorder!(node.left) if node.left
    arr += BinarySearchTree.preorder!(node.right) if node.right

    arr
  end

  # ***************************************************************************
  # IN ORDER
  # ***************************************************************************

  def self.inorder!(node)
    return [] unless node

    arr = []
    arr += BinarySearchTree.inorder!(node.left) if node.left
    arr << node.value
    arr += BinarySearchTree.inorder!(node.right) if node.right

    arr
  end

  # ***************************************************************************
  # POST ORDER
  # ***************************************************************************

  def self.postorder!(node)
    return [] unless node

    arr = []
    arr += BinarySearchTree.postorder!(node.left) if node.left
    arr += BinarySearchTree.postorder!(node.right) if node.right
    arr << node.value

    arr
  end

  def self.height!(node)
    return -1 unless node

    1 + [BinarySearchTree.height!(node.left), BinarySearchTree.height!(node.right)].max
  end

  # ***************************************************************************
  # MAX
  # ***************************************************************************

  def self.max(node)
    return nil unless node
    return node unless node.right

    BinarySearchTree.max(node.right)
  end

  # ***************************************************************************
  # MIN
  # ***************************************************************************

  def self.min(node)
    return nil unless node
    return node unless node.left

    BinarySearchTree.min(node.left)
  end

  # ***************************************************************************
  # DELETE MIN
  # ***************************************************************************

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left

    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  # ***************************************************************************
  # DELETE
  # ***************************************************************************

  def self.delete!(node, value)
    return nil unless node

    if value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif value > node.value
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      return node.left unless node.right
      return node.right unless node.left
      t = node
      node = t.right.min
      node.right = BinarySearchTree.delete_min!(t.right)
      node.left = t.left
    end

    node
  end
end
