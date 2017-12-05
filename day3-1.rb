input = 277678

distance = 0

root = Math::sqrt input
rounded_root = root.ceil

# Round up to next odd number if even
rounded_root += 1 if rounded_root % 2 == 0

square_length = rounded_root - 1

root_squared = rounded_root * rounded_root
difference = root_squared - input

square_center = square_length / 2

corner_offset = difference % square_length
center_offset = (square_center - corner_offset).abs

# Got to be a more mathematical way of doing this...
if corner_offset == 0
  distance = square_length

elsif center_offset == 0
  distance = square_length / 2

else
  distance = square_length - (square_center - center_offset)

end

puts distance