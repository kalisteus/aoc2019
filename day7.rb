require_relative 'intcode'

INPUT_PATH = File.expand_path('./input/day7.txt', __dir__)
program = File.read(INPUT_PATH).split(',')
program.map!{|e| e.to_i}

runIntcode(program)

phase_results = []
all_combinations = (0..4).to_a.permutation(5).to_a
all_combinations.each do |combo|
  input = 0
  combo.each do |phase|
    result = runIntcode(program.clone, [phase, input])
    input = result[1].last
  end
  phase_results << input
end
p phase_results.max


feedback_results = []
all_combinations = (5..9).to_a.permutation(5).to_a
all_combinations.each do |combo|
  fb_program = program.clone
  input = 0
  combo.each do |phase|
    result = runIntcode(program.clone, [phase, input])
    fb_program = result.first
    input = result.last.last
  end
  feedback_results << input
end
p feedback_results.max
