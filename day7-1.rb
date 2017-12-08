input = []
File.open('inputs/day7.txt') {|f|
  f.each_line {|line|
    input.push line
  }
}

class Node
  attr_reader :name, :weight, :children

  def initialize(node_string)
    @name, @weight, children = node_string.match(/(^.*)\s\((.*)\)(\s\-\>\s(.*))*/).captures

    if children
      @children = children.tr(' ', '').tr('->', '').split(',')

    else
      @children = nil

    end

  end

end

nodes = {}

input.each {|entry|
  node = Node.new entry
  nodes[node.name] = node
}

nodes_with_children = []
nodes.each {|name,node|
  nodes_with_children.push name if node.children && node.children.length > 0
}

nodes.each {|name,node|
  if node.children
    node.children.each {|child_name|
      if nodes_with_children.include? child_name
        nodes_with_children.delete child_name

      end

    }

  end

}

puts nodes_with_children.length

p nodes_with_children