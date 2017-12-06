input = ''
File.open('inputs/day6.txt') {|f|
  f.each_line {|line|
    input = line
  }
}

registers = input.split(' ').map(&:to_i)

combinations = []
combinations.push registers.join '|'
duplicates_found = false

redistribution_cycles = 0

def getHighestIndex(registers)
  highest_value = 0
  highest_index = 0

  current_index = 0
  registers.each {|register|
    if register > highest_value
      highest_value = register
      highest_index = current_index

    end

    current_index += 1
  }

  highest_index

end

while !duplicates_found
  redistribution_cycles += 1

  highest_index = getHighestIndex registers

  value = registers[highest_index]
  registers[highest_index] = 0

  current_index = highest_index + 1
  for i in 1..value
    current_index = 0 if current_index >= registers.length

    registers[current_index] += 1
    current_index += 1

  end

  current_layout = registers.join '|'

  if combinations.include? current_layout
    duplicates_found = true

  else
    combinations.push current_layout

  end

end

puts redistribution_cycles