Position = Struct.new('Position', :x, :y)

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n").map do |line|
  direction, steps = line.split(' ')

  [direction.to_sym, steps.to_i]
end

head = Position.new(0, 0)
tail = Position.new(0, 0)
tail_history = []

def is_neighbour?(a, b)
  (a.x - b.x).abs <= 1 && (a.y - b.y).abs <= 1
end

input.each do |direction, steps|
  steps.times do
    last_head = head.dup

    case direction
    when :U then head.y += 1
    when :D then head.y -= 1
    when :R then head.x += 1
    when :L then head.x -= 1
    end

    tail = last_head unless is_neighbour?(head, tail)
    tail_history << [tail.x, tail.y].join('-')
  end
end

puts tail_history.uniq.size
