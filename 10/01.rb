# frozen_string_literal: true

cycles = []

File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n").each do |line|
  op, number = line.split(' ')

  cycles.push('0')
  cycles.push(number) if op != 'noop'
end

sum = 1
signal_strength = 0
cycles.each_with_index do |cycle, cycle_index|
  cycle_number = cycle_index + 1

  signal_strength += cycle_number * sum if cycle_number.positive? && ((cycle_number + 20) % 40).zero?
  sum += cycle.to_i
end

puts signal_strength
