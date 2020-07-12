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
        cond = false
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
                                cond = true
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
                            end
                        end
                    else
                        root.left = Node.new(val)
                    end
                end
            end 
            cond = false
        end
        return root
    end
    
end