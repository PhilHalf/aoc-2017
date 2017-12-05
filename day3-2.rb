target = 277678

value = 1
@xposition = 0
@yposition = 0

@cells = {@xposition.to_s + ',' + @yposition.to_s => value}

heading = :right

def move(heading)
  case heading
  when :up
    @yposition += 1

  when :right
    @xposition += 1

  when :left
    @xposition -= 1

  when :down
    @yposition -= 1

  end

end

def tryTurningLeft(heading)
  new_heading = heading

  case heading
  when :up
    new_heading = :left if !@cells.has_key? ((@xposition-1).to_s + ',' + @yposition.to_s)

  when :right
    new_heading = :up if !@cells.has_key? (@xposition.to_s + ',' + (@yposition+1).to_s)

  when :left
    new_heading = :down if !@cells.has_key? (@xposition.to_s + ',' + (@yposition-1).to_s)

  when :down
    new_heading = :right if !@cells.has_key? ((@xposition+1).to_s + ',' + @yposition.to_s)

  end

  new_heading

end

def calculateCurrentCellValue
  cell_value = 0

  for y in -1..1

    for x in -1..1
      cell_value += @cells[(@xposition + x).to_s + ',' + (@yposition + y).to_s] if @cells.has_key? (@xposition + x).to_s + ',' + (@yposition + y).to_s

    end

  end

  cell_value

end

while value < target
  move heading

  value = calculateCurrentCellValue
  @cells[@xposition.to_s + ',' + @yposition.to_s] = value

  heading = tryTurningLeft heading

end

puts value