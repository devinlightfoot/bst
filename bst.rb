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
    if data < @data
      @left.nil? ? @left = Node.new( data ) : @left.insert( data )
    elsif data >= @data
      @right.nil? ? @right = Node.new( data ) : @right.insert( data )
    end
  end
end
class Tree
  attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr)
  end
  def build_tree(arr)
    arr.uniq!.sort!
    tmp = @root
    arr.each do |val|
      self.insert(val)
    end
    return @root
  end
  def insert( data )
    if @root.nil?
      @root = Node.new( data )
    else
      @root.insert( data )
    end
  end

  # needs work
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
  def search( val, node=@root )
    return nil if node.nil?
    if val < node.data
      search(val, node.left )
    elsif val > node.data
      search(val, node.right )
    else
      return node
    end
  end
  def level_order(node = @root)
    q = []
    ret = []
    q.push(node)
    while(!q.empty?)
      tmp = q.shift
      if(tmp.left) then q.push(tmp.left) end
      if(tmp.right) then q.push(tmp.right) end
      ret.push(tmp.data)
    end
    return ret
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

  def depth(node)
    return 0 if node.nil?

    leftdepth = depth(node.left)
    return -1 if leftdepth == -1

    rightdepth = depth(node.right)
    return -1 if rightdepth == -1

    diff = leftdepth - rightdepth
    if diff.abs > 1
      -1
    else
      [leftdepth, rightdepth].max + 1
    end
  end

  def balanced?(node = @root)
    depth(node) == -1 ? false : true
  end
  #needs work
  def rebalance()
    while !self.balanced?
      arr = self.level_order
      binding.pry
      @root = self.build_tree(arr)
    end
  end
end
class Driver
  def initialize()
    tree = Tree.new(Array.new(15) { rand(1..100) })
    puts "Balanced?: #{tree.balanced?}"
    tree.rebalance
    puts "level_order"
    puts tree.level_order
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

