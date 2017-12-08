input = []
File.open('inputs/day7.txt') {|f|
  f.each_line {|line|
    input.push line
  }
}

class Node
  attr_reader :name, :weight, :children, :child_nodes, :child_weight, :total_weight
  attr_accessor :parent

  def initialize(node_string)
    @name, @weight, children = node_string.match(/(^.*)\s\((.*)\)(\s\-\>\s(.*))*/).captures
    @child_nodes = []
    @parent = nil

    @weight = @weight.to_i
    if children
      @children = children.tr(' ', '').tr('->', '').split(',')

    else
      @children = nil

    end

  end

  def addChildNode node
    @child_nodes.push node
    node.parent = self

  end

  def calculateWeight
    puts "Calculating weight of #{@name}"

    @child_weight = 0
    if @children
      @child_nodes.each {|node|
        @child_weight += node.calculateWeight
      }
    end

    @total_weight = @weight + @child_weight

  end

end

nodes = {}
root_node = 'svugo'
#root_node = 'tknk'

input.each {|entry|
  node = Node.new entry
  nodes[node.name] = node
}

nodes.each {|name, node|
  if node.children
    node.children.each {|child_node_name|
      node.addChildNode nodes[child_node_name]
    }

  end
}

nodes[root_node].calculateWeight

current_node = nodes[root_node]

imbalanced_node_found = nil

imbalanced_node_found = false
while !imbalanced_node_found
  if current_node.children
    imbalanced_weight = 0

    child_weights = Hash.new 0
    current_node.child_nodes.each {|child_node|
      child_weights[child_node.total_weight] += 1
    }

    child_weights.each {|weight,count|
      if count == 1
        imbalanced_weight = weight
        break

      end
    }

    if imbalanced_weight != 0
      current_node.child_nodes.each {|child_node|
        if child_node.total_weight == imbalanced_weight
          current_node = child_node
          break

        end
      }

    else
      imbalanced_node = current_node
      imbalanced_node_found = true

    end

  else
    imbalanced_node = current_node.parent
    imbalanced_node_found = true

  end

end

parent_node = imbalanced_node.parent
if parent_node
  child_weights = Hash.new 0
  parent_node.child_nodes.each {|child_node|
    child_weights[child_node.total_weight] += 1
  }

  expected_weight = 0
  child_weights.each {|weight,count|
    if count > 1
      expected_weight = weight
      break

    end
  }

  weight_difference = expected_weight - imbalanced_node.child_weight

else
  puts 'Invalid imbalanced node found'

end

puts "Weight difference: #{weight_difference}"