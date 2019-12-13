
def runIntcode(program,  inputs = [], userInputEnabled = true)
  def formatProgramOpcode(code)
    "%05d" % code
  end

  def getOpcodeMode(code)
    [
      (code.split('')[3] + code.split('')[4]).to_i,
      (code.split('')[2]).to_i,
      (code.split('')[1]).to_i,
      (code.split('')[0]).to_i,
    ]
  end

  def getValue(program, rb, mode, param)
    if mode === 0
      return program[param]
    elsif mode === 1
      return param
    elsif mode === 2
      return program[rb + param]
    end
  end

  # Outputs
  outputs = []
  # Input Index
  ii = 0
  # Instruction Pointer
  ip = 0
  # Relative base
  rb = 0
  # Get first opcode & parameter Modes
  opcode_mode = formatProgramOpcode(program[ip])
  opcode_mode_array = getOpcodeMode(opcode_mode)
  opcode = opcode_mode_array[0]

  # Run program
  while (opcode === 1||
    opcode === 2 ||
    opcode === 3 ||
    opcode === 4 ||
    opcode === 5 ||
    opcode === 6 ||
    opcode === 7 ||
    opcode === 8 ||
    opcode === 9 ||
    opcode === 99)

    # By default the ip will be incremented automatically
    adjust_ip = true

    # Init params and values
    param1 = program[ip+1]
    param2 = program[ip+2]
    param3 = program[ip+3]
    value1 = getValue(program, rb, opcode_mode_array[1], param1) if !param1.nil?
    value2 = getValue(program, rb, opcode_mode_array[2], param2) if !param2.nil?
    value3 = getValue(program, rb, opcode_mode_array[3], param3) if !param3.nil?

    ip_inc = nil
    case opcode
    when 1..2
      # Calculate result
      if opcode === 1
        result = value1 + value2
      elsif opcode === 2
        result = value1 * value2
      end

      # Write the result
      program[param3] = result

      # Determine ip increment
      ip_inc = 4
    when 3
      input = inputs[ii]
      input = outputs.last if !userInputEnabled
      input = gets.to_i if input.nil? && userInputEnabled
      # Write the result
      program[param1] = input

      # Determine ip increment
      ip_inc = 2
      ii += 1
    when 4
      # Output the parameter value
      p "Program output: " << value1.to_s
      outputs << value1

      # Determine ip increment
      ip_inc = 2
    when 5
      if value1 != 0 then
        ip = value2
        adjust_ip = false
      end
      ip_inc = 3
    when 6
      if value1 == 0 then
        ip = value2
        adjust_ip = false
      end
      ip_inc = 3
    when 7
      if value1 < value2 then
        program[param3] = 1
      else
        program[param3] = 0
      end
      ip_inc = 4
    when 8
      if value1 == value2 then
        program[param3] = 1
      else
        program[param3] = 0
      end
      ip_inc = 4
    when 9
      rb += value1
      ip_inc = 2
    when 99
      #puts "End program"
      break 2
    else
      puts "Invalid opcode"
      break 2
    end

    ip += ip_inc if adjust_ip
    opcode_mode = formatProgramOpcode(program[ip])
    opcode_mode_array = getOpcodeMode(opcode_mode)
    opcode = opcode_mode_array[0]
  end

  return [program, outputs]
end
