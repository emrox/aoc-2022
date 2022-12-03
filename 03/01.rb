# frozen_string_literal: true

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n")

prioritysum = 0

input.each do |line|
  first = line[0, line.length / 2].split('').uniq
  second = line[(line.length / 2)...].split('').uniq
  prioritysum += (first & second).map(&:ord).map { |c| c - (c >= 97 ? 96 : 38) }.first
end

puts prioritysum
