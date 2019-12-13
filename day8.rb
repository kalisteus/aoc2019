INPUT_PATH = File.expand_path('./input/day8.txt', __dir__)
data = File.read(INPUT_PATH).strip

width = 25
height = 6

split_data = data.scan(/.{25}/)
p split_data.length

layers = []
height.times do |i|

end
