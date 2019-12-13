wires = []

File.foreach("day3.txt") do |line, i|
  coordinates = []
  x = 0
  y = 0

  wire = line.split(',')
  wire.each do |instruction|
    # Determine direction and distance
    direction = instruction[0]
    instruction[0] = ''
    distance = instruction.to_i

    distance.times do
      case direction
      when 'U'
        y += 1
      when 'D'
        y -= 1
      when 'L'
        x -= 1
      when 'R'
        x += 1
      end

      coordinates << [x, y]
    end
  end

  wires << coordinates
end

m_scores = []
intersections = wires[0] & wires[1]
intersections.each do |insn|
  # Calculate Manhattan scores
  m_scores << insn[0].abs + insn[1].abs
end
p m_scores.min
