input = []
File.open('inputs/day5.txt') {|f|
  f.each_line {|line|
    input.push line.to_i
  }
}

number_of_moves = 0
current_index = 0
previous_index = 0

inside_range = true

while inside_range
  current_index = current_index + input[current_index]
  input[previous_index] += 1

  previous_index = current_index

  number_of_moves += 1

  inside_range = false if current_index < 0 || current_index >= input.length

end

puts number_of_moves