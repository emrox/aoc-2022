# frozen_string_literal: true

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n")

instruction_split_line = input.index('')

stacks = []

(instruction_split_line - 1).times do |line|
  line_stacks = input[line].scan(/((?:\[(\w)\]|\s{3})\s?)/).map { |m| m[1] }

  line_stacks.each_index do |line_stack_index|
    stacks[line_stack_index] = [] unless stacks[line_stack_index]
    stacks[line_stack_index].unshift(line_stacks[line_stack_index]) if line_stacks[line_stack_index]
  end
end

input[(instruction_split_line + 1)..].each do |line|
  instruction = line.scan(/move (\d+) from (\d+) to (\d+)/).first.map(&:to_i)
  stacks[instruction[2] - 1] = stacks[instruction[2] - 1] + stacks[instruction[1] - 1].pop(instruction[0]).reverse
end

puts stacks.map(&:last).join
