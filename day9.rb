require_relative 'intcode_class'

INPUT_PATH = File.expand_path('./input/day9.txt', __dir__)
program = File.read(INPUT_PATH).split(',')
program.map!{|e| e.to_i}


intcode = Intcode.new(program.clone, 4096, true)
intcode.add_input(2)
intcode.run
p intcode.flush_output
