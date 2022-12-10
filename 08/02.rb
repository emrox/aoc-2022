# frozen_string_literal: true

trees = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n").map { |l| l.split('').map(&:to_i) }
highest_scenic_score = 0

trees.each_index do |y|
  trees[y].each_index do |x|
    view_distances = [0, 0, 0, 0]

    # view to top
    y.times do |t|
      view_distances[0] += 1

      break if trees[y - t - 1][x] >= trees[y][x]
    end

    # view to bottom
    (trees.length - y - 1).times do |t|
      view_distances[2] += 1

      break if trees[y + t + 1][x] >= trees[y][x]
    end

    # view to right
    (trees[0].length - x - 1).times do |t|
      view_distances[1] += 1

      break if trees[y][x + t + 1] >= trees[y][x]
    end

    # view to left
    x.times do |t|
      view_distances[3] += 1

      break if trees[y][x - t - 1] >= trees[y][x]
    end

    scenic_score = view_distances[0] * view_distances[1] * view_distances[2] * view_distances[3]
    highest_scenic_score = scenic_score if scenic_score > highest_scenic_score
  end
end

puts highest_scenic_score
