# frozen_string_literal: true

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n")

prioritysum = 0

(input.length / 3).times do |t|
  base_line = 3 * t
  common_letter = input[base_line].split('') & input[base_line + 1].split('') & input[base_line + 2].split('')
  prioritysum += common_letter.map(&:ord).map { |c| c - (c >= 97 ? 96 : 38) }.first
end

puts prioritysum
