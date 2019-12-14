require_relative 'intcode_class'

INPUT_PATH = File.expand_path('./input/day13.txt', __dir__)
program = File.read(INPUT_PATH).split(',')
program.map!{|e| e.to_i}

program[0] = 2
intcode = Intcode.new(program, 4096, false)

game_state = []

opcode_output = 0
while opcode_output != 99
  # Run the program
  intcode.run
  program_output = intcode.flush_output
  # Store the outputs
  opcode_output = program_output[0]
  buffer = program_output[1]

  # Generate instructions from program output
  instructions = []
  i = 0
  while i < buffer.length
    ci = []
    3.times do
      ci << buffer[i]
      i += 1
    end
    instructions << ci
  end

  block_tiles = []
  paddle_tile = nil
  ball_tile = nil
  score_tile = nil
  instructions.each do |inst|
    block_tiles << inst if inst[2] == 2
    paddle_tile = inst if inst[2] == 3
    ball_tile = inst if inst[2] == 4
    score_tile = inst if inst[0] == -1 && inst[1] == 0
  end

  # Save necessary game state
  game_state[0] = ball_tile if !ball_tile.nil?
  game_state[1] = paddle_tile if !paddle_tile.nil?
  game_state[2] = score_tile if !score_tile.nil?
  game_state[3] = block_tiles.length if !block_tiles.nil?

  ball_tile = game_state[0]
  paddle_tile = game_state[1]
  #determine joystick movement
  joystick_movement = -1 if paddle_tile[0] > ball_tile[0]
  joystick_movement = 0 if paddle_tile[0] == ball_tile[0]
  joystick_movement = 1 if paddle_tile[0] < ball_tile[0]
  intcode.add_input(joystick_movement)

  p game_state[3] if !game_state[3].nil?
  p game_state[2][2] if !game_state[2].nil?
  p '---------------------------------------'
end
