# frozen_string_literal: true

input = File.read('01.input').split("\n")

elves = [0]

input.each do |line|
  elves.push(0) if line == ''
  elves[elves.length - 1] += line.to_i
end

puts "Part 1: #{elves.max}"
puts "Part 2: #{elves.max(3).sum}"
