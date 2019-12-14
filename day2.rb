require_relative 'intcode_class'

INPUT_PATH = File.expand_path('./input/day2.txt', __dir__)
program = File.read(INPUT_PATH).split(',')
program.map!{|e| e.to_i}

program[1] = 12
program[2] = 2

intcode = Intcode.new(program.clone, 0, true)
intcode.run
p intcode.flush_output
