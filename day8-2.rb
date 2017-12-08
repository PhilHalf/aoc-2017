input = []
File.open('inputs/day8.txt') {|f|
  f.each_line {|line|
    input.push line
  }
}

class Condition
  attr_reader :register, :comparator, :value
end

class Instruction
  attr_reader :name, :action, :value, :condition
end

registers = Hash.new 0
highest_value = -99999

input.each {|instruction|
  register_name, action, value, condition = instruction.match(/(^.*)\s(inc|dec)\s(-?\d+)\s(.*)/).captures
  value = value.to_i

  if !registers.has_key? register_name
    registers[register_name] = 0

  end

  compare_register, comparator, compare_value = condition.match(/^if\s(.*)\s(.*)\s(-?\d+)/).captures
  compare_value = compare_value.to_i

  if !registers.has_key? compare_register
    registers[compare_register] = 0

  end

  run_instruction = false
  case comparator
  when '>'
    run_instruction = registers[compare_register] > compare_value

  when '<'
    run_instruction = registers[compare_register] < compare_value

  when '>='
    run_instruction = registers[compare_register] >= compare_value

  when '<='
    run_instruction = registers[compare_register] <= compare_value

  when '=='
    run_instruction = registers[compare_register] == compare_value

  when '!='
    run_instruction = registers[compare_register] != compare_value

  end

  if run_instruction
    case action
    when 'inc'
      registers[register_name] += value

    when 'dec'
      registers[register_name] -= value

    end

    highest_value = registers[register_name] if registers[register_name] > highest_value
    
  end
}

puts highest_value