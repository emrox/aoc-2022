# frozen_string_literal: true

require 'set'

checked_line = ARGV.first == 'd' ? 10 : 2_000_000

@beacons = Set.new
sensor_beacon_coordinates = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n").map do |line|
  s_x, s_y, b_x, b_y = line.match(/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/)
                           .captures
                           .map(&:to_i)

  @beacons << [b_x, b_y]

  [[s_x, s_y], [b_x, b_y]]
end

non_beacon_positions = Set.new

sensor_beacon_coordinates.each do |sensor, closest_beacon|
  x = [sensor[0], closest_beacon[0]].sort
  y = [sensor[1], closest_beacon[1]].sort
  steps = (x[0] - x[1]).abs + (y[0] - y[1]).abs

  next if checked_line < sensor[1] - steps || checked_line > sensor[1] + steps

  line_steps = steps - (checked_line - sensor[1]).abs

  line_non_beacons = [*(sensor[0] - line_steps)..(sensor[0] + line_steps)].to_set
  non_beacon_positions += line_non_beacons
end

@beacons.each do |beacon|
  non_beacon_positions = non_beacon_positions.delete(beacon[0]) if checked_line == beacon[1]
end

puts non_beacon_positions.size
