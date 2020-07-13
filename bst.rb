# frozen_string_literal: true

class Node
  include Comparable
  attr_accessor :data, :left, :right
  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end
  def insert( data )
    if data <= @data
      @left.nil? ? @left = Node.new( data ) : @left.insert( data )
    elsif data > @data
      @right.nil? ? @right = Node.new( data ) : @right.insert( data )
    end
  end
end
class Tree
  attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr)
  end
#broken
  def build_tree(arr)
    arr.uniq.sort
    tmp = @root
    arr.each do |val|
      self.insert(val)
    end
    return @root
  end

  # works?
  def insert( data )
    if @root.nil?
      @root = Node.new( data )
    else
      @root.insert( data )
    end
  end

  # works?
  def delete(val)
    cond = true
    tmp = @root
    while cond
      if @root.data == val && @root.left.nil? && @root.right.nil?
        cond = false
        return nil
      elsif tmp.data != val && tmp.left.nil? && tmp.right.nil?
        return nil
      elsif @root.data == val && @root.left.nil? && @oot.right.nil?
        @root = build_tree(preorder(@root, val))
      elsif tmp.left.data == val
        tmp = build_tree(preorder(tmp, val))
        cond = false
      elsif tmp.right.data == val
        tmp = build_tree(preorder(tmp, val))
        cond = false
      else
        if val > tmp.data
          tmp = tmp.right
        elsif val < tmp.data
          tmp = tmp.left
          end
      end
    end
  end

  # works?
  def find(val)
    cond = true
    tmp = @root
    while cond
      return nil if @root.nil?

      if tmp.data == val
        cond = true
        return tmp.data
      elsif tmp.left.data == val
        return tmp.left.data
      elsif tmp.right.data == val
        return tmp.right.data
      elsif tmp.left.nil? && tmp.right.nil? && tmp.data != val
        return nil
      else
        tmp = if val > tmp.data
                tmp.right
              else
                tmp.left
              end
      end
    end
  end

  # broken
  def level_order
    arr = []
    q = []
    q.push(@root)
    cond = true
    while cond
      break if q.empty?

      tmp = q[0]
      arr.push(tmp.data)
      if !tmp.left.nil?
        q.push(tmp.left)
      elsif !tmp.right.nil?
        q.push(tmp.right)
      end
      q.pop
    end
    arr
  end

  def pre_order(node = @root, &block)
    return if node.nil?

    yield node
    in_order(node.left, &block)
    in_order(node.right, &block)
  end

  def in_order(node = @root, &block)
    return if node.nil?

    in_order(node.left, &block)
    yield node
    in_order(node.right, &block)
   end

  def post_order(node = @root, &block)
    return if node.nil?

    in_order(node.left, &block)
    in_order(node.right, &block)
    yield node
  end

  def height(node)
    return 0 if node.nil?

    leftHeight = check_height(node.left)
    return -1 if leftHeight == -1

    rightHeight = check_height(node.right)
    return -1 if rightHeight == -1

    diff = leftHeight - rightHeight
    if diff.abs > 1
      -1
    else
      [leftHeight, rightHeight].max + 1
    end
  end

  def balanced?(node = @root)
    height(node) != -1
  end
end
class Driver
  def initialize()
    tree = Tree.new(Array.new(15) { rand(1..100) })
    puts 'pre_order'
    tree.pre_order do |node|
      puts node.data
    end

    puts 'in_order'
    tree.in_order do |node|
     puts node.data
    end

    puts 'post_order'
    tree.post_order do |node|
      puts node.data
    end
  end
end
driver = Driver.new

