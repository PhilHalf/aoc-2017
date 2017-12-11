input = ''
File.open('inputs/day9.txt') {|f|
  f.each_line {|line|
    input += line
  }
}

class Group
  attr_reader :level, :children

  def initialize level
    @level = level
    @children = []

  end

  def parse data, offset = 1
    while offset < data.length
      if data[offset] == '{'
        child_group = Group.new @level + 1
        @children.push child_group
        offset = child_group.parse data, offset + 1

      elsif data[offset] == '}'
        offset += 1
        break

      elsif data[offset] == '<'
        child_garbage = Garbage.new
        @children.push child_garbage
        offset = child_garbage.parse data, offset + 1

      else
        offset += 1

      end
      
    end

    offset

  end

end

class Garbage
  attr_reader :contents

  def parse data, offset = 1
    garbage_close_index = data.slice(-(data.length - offset), data.length).index('>')
    @contents = data.slice(offset, garbage_close_index).join

    offset + garbage_close_index

  end

end

def removeCancelledCharacters data
  exclamation_index = data.index '!'
  while exclamation_index
    # Remove the exclamation mark and the next character
    data.slice! exclamation_index, 2

    exclamation_index = data.index '!'

  end

  data

end

def traverseGroupsAndGetGarbageLength node
  length = 0
  
  node.children.each {|child|
    if child.class == Garbage
      length += child.contents.length

    elsif child.class == Group
      length += traverseGroupsAndGetGarbageLength child

    end
  }

  length

end

data = input.split //
data = removeCancelledCharacters data

root_group = Group.new 1
root_group.parse data

garbage_length = traverseGroupsAndGetGarbageLength root_group

puts garbage_length