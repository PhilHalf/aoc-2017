input = []
File.open('inputs/day2.txt') {|f|
  f.each_line {|line|
    input.push line
  }
}

checksum = 0

input.each {|line|
  entries = line.split("\t")

  continue = true

  for i in 0..entries.length
    for j in 0..entries.length
      next if i == j

      if (entries[i].to_f / entries[j].to_f) % 1 == 0
        checksum += entries[i].to_i / entries[j].to_i
        continue = false

        break

      end
      
    end

    break if !continue

  end
}

puts checksum