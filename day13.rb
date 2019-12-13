require_relative 'intcode'

INPUT_PATH = File.expand_path('./input/day13.txt', __dir__)
program = File.read(INPUT_PATH).split(',')
program.map!{|e| e.to_i}
#program[0] = 2

memory = []
4096.times.each{|i| memory << 0}

result = runIntcode(program.concat(memory))
output = result[1]

instructions = []
i = 0
while i < output.length
  current_instruction = []
  3.times do
    current_instruction << output[i]
    i += 1
  end
  instructions << current_instruction
end

block_tiles = []

instructions.each do |inst|
  block_tiles << inst if inst[2] == 2
  p inst if inst[2] == 3
  p inst if inst[2] == 4
end
p block_tiles.length
