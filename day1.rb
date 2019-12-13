total = 0
total2 = 0
File.foreach("input1.txt") { |line|
  val = line.to_i
  val = val/3
  val.floor
  val = val-2
  total += val

  intermediate = val
  while intermediate >= 0
    intermediate = intermediate/3
    intermediate.floor
    intermediate = intermediate-2
    if intermediate > 0
      total2 += intermediate
    end
  end
}
puts total
puts total2
puts total + total2
