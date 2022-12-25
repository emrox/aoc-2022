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

width = dimension[1] - dimension[0] + 1
adjusted_center = center_point - dimension[0]

area = [*0..lines].map { |_l| '.' * width }

walls.each_with_index do |wall, _wall_index|
  wall.each_with_index do |point, point_index|
    next if point_index.zero?

    prev_point = wall[point_index - 1]

    if prev_point[0] == point[0]
      # vertical
      sort_points = [prev_point[1], point[1]].sort
      (sort_points[0]..sort_points[1]).each do |y|
        area[y][point[0] - dimension[0]] = '#'
      end
    else
      # horizontal
      sort_points = [prev_point[0], point[0]].sort
      (sort_points[0]..sort_points[1]).each do |x|
        area[point[1]][x - dimension[0]] = '#'
      end
    end
  end
end

iterations = 0
into_the_void = false

until into_the_void
  iterations += 1
  x_pos = adjusted_center

  [*0..lines].each do |line|
    next_line = line + 1
    if next_line > lines
      into_the_void = true
      break
    end

    next if area[next_line][x_pos] == '.'

    if area[next_line][x_pos - 1] == '.'
      x_pos -= 1
    elsif area[next_line][x_pos + 1] == '.'
      x_pos += 1
    else
      area[line][x_pos] = 'o'
      break
    end
  end

  # uncomment to see the flow
  # area.each { |l| puts l }
  # sleep 0.01
end

puts "iterations: #{iterations - 1}"
