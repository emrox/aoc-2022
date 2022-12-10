# frozen_string_literal: true

cycles = []

File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n").each do |line|
  op, number = line.split(' ')

  cycles.push('0')
  cycles.push(number) if op != 'noop'
end

sprite_position = 1
crt = []

cycles.each_with_index do |cycle, cycle_index|
  crt.push('#' * 40) if (((cycle_index - 0) % 40).zero? && cycle_index > 10) || cycle_index.zero?
  draw_pixel = cycle_index % 40
  crt[crt.size - 1][draw_pixel] = draw_pixel >= sprite_position - 1 && draw_pixel <= sprite_position + 1 ? '#' : '.'
  sprite_position += cycle.to_i
end

puts crt
