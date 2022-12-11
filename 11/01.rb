# frozen_string_literal: true

monkeys = File.read(ARGV.first == 'd' ? 'debug' : 'input').scan(/
  Monkey.([0-9]+):\s+
  Starting.items:.([\d,\s]+)+
  Operation:.new.=.old.([+*]).([\d\w]+)\s+
  Test:.divisible.by.(\d+)\s+
  If.true:.throw.to.monkey.(\d+)\s+
  If.false:.throw.to.monkey.(\d+)
/mx).map do |block|
  {
    items: block[1].strip.split(', ').map(&:to_i),
    operation: { operator: block[2], operand: block[3] == 'old' ? 'old' : block[3].to_i },
    test: { divisor: block[4].to_i },
    if_true: block[5].to_i,
    if_false: block[6].to_i,
    inspected_items: 0
  }
end

20.times do |_round|
  monkeys.each_with_index do |monkey, index|
    monkey[:items].each do |worry_level|
      operand = monkey[:operation][:operand] == 'old' ? worry_level : monkey[:operation][:operand]
      worry_level = worry_level.send(monkey[:operation][:operator], operand) / 3
      throw_to = (worry_level % monkey[:test][:divisor]).zero? ? monkey[:if_true] : monkey[:if_false]
      monkeys[throw_to][:items].push(worry_level)
      monkeys[index][:inspected_items] += 1
    end
    monkeys[index][:items] = []
  end
end

puts monkeys.map { |m| m[:inspected_items] }.max(2).inject(:*)
