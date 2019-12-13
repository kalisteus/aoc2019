INPUT_PATH = File.expand_path('./input/day6.txt', __dir__)
om = Hash.new

def getParent(hash, child)
  hash[child]
end

File.foreach(INPUT_PATH) do |line|
  split_line = line.split(')')
  parent = split_line[0].strip
  child = split_line[1].strip

  om[child] = parent
end
om2 = om.clone

total = 0
you_map = []
san_map = []
om.each do |(key,value)|
  child = key
  parent = getParent(om2, child)
  distance = 1
  until parent == 'COM'
    you_map << parent if key == 'YOU'
    san_map << parent if key == 'SAN'

    child = parent
    parent = getParent(om2, child)
    distance += 1
  end
  total += distance
end
you_san_shared = you_map & san_map
you_san_path = (you_map - you_san_shared) + [you_san_shared[0]] + (san_map - you_san_shared)
p you_san_path.length
p total
