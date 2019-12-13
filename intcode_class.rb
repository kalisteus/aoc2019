class Intcode
  def initialize(program, input = [], interactive = true)
    @programState = program
    @interactive = interactive

    @input = input
    # Input Iterator
    @ii = 0

    # Instruction Pointer
    @ip = 0
    # Relative Base
    @rb = 0

    @output = []

    @opcode
    @params = []
    @values = []
    @addresses = []

    @return_program = false
  end

  def add_input(value)
    @inputs << value
  end

  def get_output
    @output
  end

  def flush_output
    output = @output
    @output = []
    output
  end

  def run()
    while !@return_program
      read_next_operation

      case @opcode
      when 1..2 # ADD || MULTIPLY
        # Calculate result
        if @opcode === 1
          result = @values[0] + @values[1]
        elsif @opcode === 2
          result = @values[0] * @values[1]
        end
        # Write the result
        write_value(@addresses[2], result)
        # Increment Instruction Pointer
        adjust_ip(4)
      when 3 #INPUT
        input = get_input
        # Write the result
        write_value(@addresses[2], input)
        # Increment Instruction Pointer
        adjust_ip(2)
      when 4 #OUTPUT
        # Write parameter value to the output
        @output << @values[0]
        # Increment Instruction Pointer
        adjust_ip(2)
      when 5
        if @values[0] != 0 then
          adjust_ip(@values[1], true)
        else
          adjust_ip(3)
        end
      when 6
        if @values[0] == 0 then
          adjust_ip(@values[1], true)
        else
          adjust_ip(3)
        end
      when 7
        if @values[0] < @values[1] then
          write_value(@addresses[2], 1)
        else
          write_value(@addresses[2], 0)
        end
        adjust_ip(4)
      when 8
        if @values[0] == @values[1] then
          write_value(@addresses[2], 1)
        else
          write_value(@addresses[2], 0)
        end
        adjust_ip(4)
      when 9
        adjust_rb(@values[0])
        adjust_ip(2)
      when 99
        @return_program = true
        break
      else
        @return_program = true
        break
      end
    end
    @return_program = false
  end

  private
  def format_code(code)
    "%05d" % code
  end

  def get_opcode_modes(code)
    [
      (code.split('')[3] + code.split('')[4]).to_i,
      (code.split('')[2]).to_i,
      (code.split('')[1]).to_i,
      (code.split('')[0]).to_i,
    ]
  end

  def get_value(mode, param)
    if mode === 0
      return @programState[param]
    elsif mode === 1
      return param
    elsif mode === 2
      return @programState[@rb + param]
    end
  end

  def get_address(mode, param)
    if mode === 0 || mode === 1
      return param
    elsif mode === 2
      return @rb + param
    end
  end

  def read_next_operation
    opcode_mode = format_code(@programState[@ip])
    opcode_mode_array = get_opcode_modes(opcode_mode)
    @opcode = opcode_mode_array[0]

    @params = Array.new
    @params << @programState[@ip+1]
    @params << @programState[@ip+2]
    @params << @programState[@ip+3]
    @values = Array.new(3, nil)
    @values << get_value(opcode_mode_array[1], @params[0]) if !@params[0].nil?
    @values << get_value(opcode_mode_array[2], @params[1]) if !@params[1].nil?
    @values << get_value(opcode_mode_array[3], @params[2]) if !@params[2].nil?
    @addresses = Array.new(3, nil)
    @addresses << get_address(opcode_mode_array[1], @params[0]) if !@params[0].nil?
    @addresses << get_address(opcode_mode_array[2], @params[1]) if !@params[1].nil?
    @addresses << get_address(opcode_mode_array[3], @params[2]) if !@params[2].nil?
  end

  def adjust_ip(value, overwrite = false)
    @ip += value if !overwrite
    @ip = value if overwrite
  end

  def adjust_rb(value)
    @rb += value
  end

  def write_value(address, value)
    @programState[address] = value
  end

  def get_input
    input = nil
    if !@interactive then
      input = @input[@ii]
      @ii += 1 if !input.nil?
      @return_program = input.nil?
    else
      input = @output.last
      input = gets.to_i if input.nil? && @interactive
    end

    input
  end
end
