require_relative 'intcode'

INPUT_PATH = File.expand_path('./input/day5.txt', __dir__)
program = File.read(INPUT_PATH).split(',')
program.map!{|e| e.to_i}

program = runIntcode(program)
