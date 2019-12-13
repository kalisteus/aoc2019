require_relative 'intcode'

clean_program = File.read("day2.txt").split(',')
clean_program.map!{|e| e.to_i}

100.times do |i|
  100.times do |j|
    #Init
    program = clean_program.clone

    # Set input values
    program[1] = i
    program[2] = j

    program = runIntcode(program)
    if (program[0] === 19690720)
      puts "verb"
      p program[1]
      puts "noun"
      p program[2]
      puts "answer"
      p 100 * program[1] + program[2]

      break 2
    end
  end
end
