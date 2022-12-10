# frozen_string_literal: true

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n")

overlapses = 0

input.each do |line|
  assignments = line.split(',').map do |assignment|
    hours = assignment.split('-').map(&:to_i)

    (hours.first..hours.last).to_a
  end

  overlapses += 1 if (assignments[0] & assignments[1]).length.positive?
end

puts overlapses
