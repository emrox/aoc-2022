# frozen_string_literal: true

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n")

scores = {
  A: { score: 1, lose: 3, win: 2 },
  B: { score: 2, lose: 1, win: 3 },
  C: { score: 3, lose: 2, win: 1 }
}

my_score = 0

input.each do |line|
  enemy, me = line.split(' ').map(&:to_sym)

  case me
  when :X
    my_score += 0 + scores[enemy][:lose]
  when :Y
    my_score += 3 + scores[enemy][:score]
  when :Z
    my_score += 6 + scores[enemy][:win]
  end
end

puts my_score
