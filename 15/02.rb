# frozen_string_literal: true

require 'set'

max = ARGV.first == 'd' ? 20 : 4_000_000

@beacons = Set.new
sensor_beacon_coordinates = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n").map do |line|
  s_x, s_y, b_x, b_y = line.match(/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/)
                           .captures
                           .map(&:to_i)

  @beacons << [b_x, b_y]

  [[s_x, s_y], [b_x, b_y]]
end

max.times do |checked_line|
  non_beacon_positions = []

  sensor_beacon_coordinates.each do |sensor, closest_beacon|
    x = [sensor[0], closest_beacon[0]].sort
    y = [sensor[1], closest_beacon[1]].sort
    steps = (x[0] - x[1]).abs + (y[0] - y[1]).abs

    next if checked_line < sensor[1] - steps || checked_line > sensor[1] + steps

    line_steps = steps - (checked_line - sensor[1]).abs

    from = sensor[0] - line_steps
    from = 0 if from.negative?

    to = sensor[0] + line_steps
    to = max if to > max

    non_beacon_positions.append([from, to])
  end

  non_beacon_positions = non_beacon_positions.sort { |a, b| a[0] <=> b[0] }.each_with_object([]) do |pos, acc|
    if acc.any? && acc.last[1] >= pos[0] - 1
      acc.last[1] = pos[1] if pos[1] > acc.last[1]
    else
      acc.append pos
    end
  end

  if non_beacon_positions.size > 1
    puts ((non_beacon_positions[0][1] + 1) * 4_000_000) + checked_line
    break
  end
end
