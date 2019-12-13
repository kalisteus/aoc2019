require_relative 'intcode'

program = File.read("day2.txt").split(',')
program.map!{|e| e.to_i}
program[1] = 77
program[2] = 5
p program

program = runIntcode(program)
p program
