INPUT_PATH = File.expand_path('./input/day8.txt', __dir__)
data = File.read(INPUT_PATH).strip

width = 25
height = 6

split_data = data.scan(/.{#{width}}/)

layers = []
i = 0
until i >= split_data.length
  current_layer = []
  height.times do
    block = []
    block = width.times.each{|i| block << 2}
    block = split_data[i] if !split_data[i].nil?
    current_layer << block
    i += 1
  end
  layers << current_layer
end

layerCount0 = []
layerCount1 = []
layerCount2 = []
layers.each do |layer|
  joined_layer = layer.join
  layerCount0 << (joined_layer.count "0")
  layerCount1 << (joined_layer.count "1")
  layerCount2 << (joined_layer.count "2")
end
min_zeros_index = layerCount0.find_index(layerCount0.min)
p layerCount1[min_zeros_index] * layerCount2[min_zeros_index]

restored_image_flat = nil
layers.reverse.each_with_index do |rlayer, i|
  current_layer = rlayer.join
  if i == 0 then
    restored_image_flat = current_layer
  else
    current_layer.each_char.with_index do |char, i|
      restored_image_flat[i] = char if (char == '0' || char == '1')
    end
  end
end

restored_image = restored_image_flat
restored_image_flat.each_char.with_index do |char, i|
  restored_image[i] = "\u25A0" if char == '1'
  restored_image[i] = "\u25A1" if char == '0'
end

restored_image = restored_image.scan(/.{#{width}}/)
restored_image.each do |line|
  puts line.encode('utf-8')
end
