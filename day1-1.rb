input = ''
File.open('inputs/day1.txt') {|f|
  f.each_line {|line|
    input += line
  }
}

current_number = 0
first_number = -1
previous_number = -1
total_sum = 0

input.each_char {|char|
  current_number = char.to_i

  first_number = current_number if first_number == -1

  total_sum += previous_number if previous_number == current_number

  previous_number = current_number
}

# Check the last number against the first number and add to the sum if they match
if current_number != nil && first_number != nil
  total_sum += current_number if current_number == first_number

end

puts total_sum