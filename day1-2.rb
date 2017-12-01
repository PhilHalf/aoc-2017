input = ''
File.open('inputs/day1.txt') {|f|
  f.each_line {|line|
    input += line
  }
}

total_sum = 0

number_array =  input.split(//)
array_length = number_array.length

for i in 0..array_length-1
  comparator_index = i + (array_length / 2)
  comparator_index -= array_length if comparator_index >= array_length

  total_sum += number_array[i].to_i if number_array[i] == number_array[comparator_index]

end

puts total_sum