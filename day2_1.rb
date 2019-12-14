require_relative 'intcode_class'

INPUT_PATH = File.expand_path('./input/day2.txt', __dir__)
program = File.read(INPUT_PATH).split(',')
program.map!{|e| e.to_i}

100.times do |i|
  100.times do |j|
    #Init
    intcode = Intcode.new(program.clone, 0, true)

    # Set input values
    program[1] = i
    program[2] = j

    intcode.run
    result = intcode.flush_output
    if (result[2][0] === 19690720)
      puts "verb"
      p i
      puts "noun"
      p j
      puts "answer"
      p 100 * i + j

      break 2
    end
  end
end
