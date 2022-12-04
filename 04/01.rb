# frozen_string_literal: true

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n")

fully_contains_count = 0

input.each do |line|
  assignments = line.split(',').map { |a| a.split('-').map(&:to_i) }

  if (assignments[0][0] >= assignments[1][0] && assignments[0][1] <= assignments[1][1]) ||
     (assignments[1][0] >= assignments[0][0] && assignments[1][1] <= assignments[0][1])
    fully_contains_count += 1
  end
end

puts fully_contains_count
