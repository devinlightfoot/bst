def Node
    include Comparable
    attr_accessor :data, :left, :right
    def initialize(data = nil)
        @data = data
        @left = left
        @right = right
    end

end
def Tree
    attr_accessor :root
    def initialize(arr)
        @root = build_tree(arr)
    end
    def build_tree(arr)
        arr.uniq.sort
        root, tmp_root = nil
        cond = true
        arr.each do |val|
            if root.nil?
                root = Node.new(val)
            else
                if val >= root.data
                    if root.right.present?
                        tmp_root = root.right
                        while cond
                           if tmp_root.left.present? && tmp_root.right.present?
                                if val >= tmp_root.data
                                    tmp_root = tmp_root.right
                                else
                                    tmp_root = tmp_root.left
                                end
                           else
                                if val >= tmp_root.data
                                    tmp_root.right = Node.new(val)
                                else
                                    tmp_root.left = Node.new(val)
                                end
                                cond = false
                           end
                        end
                    else
                        root.right = Node.new(val)
                    end
                elsif val < root.data
                    if root.left.present?
                        tmp_root = root.left
                        while cond
                            if tmp_root.left.present? && tmp_root.right.present?
                                if val >= tmp_root.data
                                    tmp_root = tmp_root.right
                                else
                                    tmp_root = tmp_root.left
                                end
                            else
                                if val >= tmp_root.data
                                    tmp_root.right = Node.new(val)
                                else
                                    tmp_root = Node.new(val)
                                end
                                cond = false
                            end
                        end
                    else
                        root.left = Node.new(val)
                    end
                end
            end 
            cond = true
        end
        return root
    end
    def insert(val)
        cond = true
        tmp = @root
        while cond
            if @root.nil?
                build_tree(val)
            elsif tmp.left.present? && tmp.right.present?
                if val >= tmp.data
                    tmp = tmp.right
                else
                    tmp = tmp.left
                end
            else
                cond = false
            end
        end
        if val >= tmp.data
            tmp.right = Node.new(val)
        else
            tmp.left = Node.new(val)
    end
    def delete(val)
        cond = true
        tmp = @root
       while cond
            if @root.data == val && @root.left.nil? && @root.right.nil?
                cond = false
                return nil
            elsif tmp.data != val && tmp.left.nil? && tmp.right.nil?
                return nil
            elsif @root.data == val && @root.left.present? && @oot.right.present?
                @root = build_tree(deconstruct(@root,val))
            elsif tmp.left.data == val
                tmp = build_tree(deconstruct(tmp,val))
                cond = false
            elsif tmp.right.data == val
            tmp = build_tree(deconstruct(tmp,val))
            cond = false
        else
            if val > tmp.data
                tmp = tmp.right
            elsif val < tmp.data
                tmp = tmp.left
            end
       end
    end
    #helper method for delete(val)
    def deconstruct(node,except = nil)
        arr = [node]
        cond = true
        while cond
            next if node.data == except
            if node.left.present? && node.right.present?
                arr.push(deconstruct(node.left,except))
                arr.push(deconstruct(node.right,except))
            else
                cond = false
            end
        end
        arr.flatten
        return arr
    end
    def find(val)
        cond = true
        tmp = @root
        while cond
            return nil if @root.nil?
            if tmp.data = val
                cond = true
                return tmp
            elsif tmp.left.data = val
                return tmp.elft
            elsif tmp.right.data = val
                return tmp.right
            elsif tmp.left.nil? && tmp.right.nil? && tmp.data != val
                return nil
            else
                if val > tmp.data
                    tmp = tmp.right
                else
                    tmp = tmp.left
                end
            end
        end
    end
end