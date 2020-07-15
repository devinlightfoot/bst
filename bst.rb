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
    arr = arr.uniq.sort
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
  def delete(val)
    arr = level_order(@root).uniq!
    arr.reject!{|node| node.data == val}
    @root = build_tree(arr)
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
        next if ret.include?(tmp.data)
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

  def depth(node = @root)
    return 0 if node.nil?
    l_depth = depth(node.left)
    r_depth = depth(node.right)
    if l_depth > r_depth + 1
      return l_depth + 1
    else
      return r_depth + 1
    end
  end

  def balanced?(node = @root)
    l_depth = depth(node.left)
    r_depth= depth(node.right)
    dif = l_depth - r_depth
    tree_depth = depth(@root)
    if l_depth == tree_depth || r_depth == tree_depth || dif.abs == 1
      return true
    else
      return false
    end
  end
  def rebalance()
    if self.balanced?
      return
    else
      arr = level_order(@root).uniq
      @root = build_tree(arr)
    end
  end
  def pretty_print(node = @root, prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
  end
end
class Driver
  def initialize()
    tree = Tree.new(Array.new(15) { rand(1..100) })
    tree.pretty_print
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
    puts "depth:"
    puts tree.depth
  end
end
driver = Driver.new

