input = []
File.open('inputs/day2.txt') {|f|
  f.each_line {|line|
    input.push line
  }
}

checksum = 0

input.each {|line|
  highest = 0
  lowest = 99999

  line.split("\t").each {|entry|
    highest = entry.to_i if entry.to_i > highest
    lowest = entry.to_i if entry.to_i < lowest
  }
  
  checksum += highest - lowest
}

puts checksum