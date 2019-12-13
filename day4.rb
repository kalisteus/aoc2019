def duplicate_hash(array)
  array.each_with_object(Hash.new(0)) do |value, hash|
    # Keep a count of all the unique values encountered
    hash[value] += 1
  end
end

def duplicate_count(array)
  duplicate_hash(array).count do |(value,count)|
    # Compute how many have a count > 1
    count > 1
  end
end

def duplicate_count_pairs(array)
  duplicate_hash(array).count do |(value,count)|
    # Compute how many have a count == 2
    count == 2
  end
end


min = 183564
max = 657474

# Valid Codes
vc = []
(min..max).step(1) do |code|
  # Code is valid until further notice
  valid_code = true

  # Test digits going up
  prev_digit = code.digits.last
  code.digits.reverse_each do |curr_digit|
    # This tests the first digit double but that's OK
    valid_code = false if prev_digit > curr_digit

    break if valid_code == false

    prev_digit = curr_digit
  end
  next if valid_code == false

  # Test double digit present
  valid_code = false if duplicate_count(code.digits) == 0
  next if valid_code == false

  # Test double digits are having at least 1 pair
  valid_code = false if duplicate_count_pairs(code.digits) == 0
  next if valid_code == false

  # Arrived here so valid Code
  vc << code
end

p vc.length
