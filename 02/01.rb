# frozen_string_literal: true

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n")

scores = {
  A: { X: 3, Y: 6, Z: 0 },
  B: { X: 0, Y: 3, Z: 6 },
  C: { X: 6, Y: 0, Z: 3 },
  X: { base: 1 },
  Y: { base: 2 },
  Z: { base: 3 }
}

my_score = 0

input.each do |line|
  enemy, me = line.split(' ').map(&:to_sym)
  my_score += scores[enemy][me] + scores[me][:base]
end

puts my_score
