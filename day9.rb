require_relative 'intcode'

INPUT_PATH = File.expand_path('./input/day9.txt', __dir__)
program = File.read(INPUT_PATH).split(',')
program.map!{|e| e.to_i}

memory = []
4096.times.each{|i| memory << 0}

runIntcode(program.concat(memory))
