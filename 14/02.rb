# frozen_string_literal: true

lines = 0
center_point = 500
dimension = [center_point, center_point]

walls = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n").map do |line|
  line.split(' -> ').map do |p|
    x, y = p.split(',').map(&:to_i)

    lines = y if y > lines
    dimension[0] = x if x < dimension[0]
    dimension[1] = x if x > dimension[1]

    [x, y]
  end
end

lines += 2

width = dimension[1] - dimension[0] + 1
adjusted_center = center_point - dimension[0]

area = [*0...width].map { |_l| [*0..lines].map { '.' } }
area.each { |l| l[-1] = '#' }

walls.each_with_index do |wall, _wall_index|
  wall.each_with_index do |point, point_index|
    next if point_index.zero?

    prev_point = wall[point_index - 1]

    if prev_point[0] == point[0]
      # vertical
      sort_points = [prev_point[1], point[1]].sort
      (sort_points[0]..sort_points[1]).each do |y|
        area[point[0] - dimension[0]][y] = '#'
      end
    else
      # horizontal
      sort_points = [prev_point[0], point[0]].sort
      (sort_points[0]..sort_points[1]).each do |x|
        area[x - dimension[0]][point[1]] = '#'
      end
    end
  end
end

iterations = 0
reached_rest = false

until reached_rest
  iterations += 1
  x_pos = adjusted_center

  [*0..lines].each do |line|
    next_line = line + 1

    next if area[x_pos][next_line] == '.'

    if area[x_pos - 1][next_line] == '.'
      if x_pos.zero?
        area.unshift((['.'] * lines) + ['#'])
        adjusted_center += 1
      else
        x_pos -= 1
      end
    elsif area[x_pos + 1][next_line] == '.'
      x_pos += 1

      area.push((['.'] * lines) + ['#']) unless area[x_pos + 1]
    else
      area[x_pos][line] = 'o'
      reached_rest = line.zero?
      break
    end
  end

  # uncomment to see the flow
  # puts "////// iteration: #{iterations} //////"
  # area.each_with_index { |l, i| puts (dimension[0] + i).to_s.rjust(4) + " " + l.join('') }
  # sleep 0.01
end

puts "iterations: #{iterations}"
