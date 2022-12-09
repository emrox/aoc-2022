# frozen_string_literal: true

trees = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n").map { |l| l.split('').map { |n| [n.to_i, false, false, false, false]  } }

# visibility from top
trees[0].each_index do |x|
  max_col_size = 0

  trees.each_index do |y|
    if y == 0 || trees[y][x][0] > max_col_size
      trees[y][x][1] = true
    end

    if trees[y][x][0] > max_col_size
      max_col_size = trees[y][x][0]
    end
  end
end

# visibility from bottom
trees[0].each_index do |x|
  max_col_size = 0

  trees.each_index do |y_o|
    y = trees.length - 1 - y_o 

    if y_o == 0 || trees[y][x][0] > max_col_size
      trees[y][x][3] = true
    end

    if trees[y][x][0] > max_col_size
      max_col_size = trees[y][x][0]
    end
  end
end

# visibility from left
trees.each_index do |y|
  max_row_size = 0

  trees[y].each_index do |x|
    if x == 0 || trees[y][x][0] > max_row_size
      trees[y][x][4] = true
    end

    if trees[y][x][0] > max_row_size
      max_row_size = trees[y][x][0]
    end
  end
end

# visibility from right
trees.each_index do |y|
  max_row_size = 0

  trees[y].each_index do |x_o|
    x = trees[0].length - 1 - x_o 

    if x_o == 0 || trees[y][x][0] > max_row_size
      trees[y][x][2] = true
    end

    if trees[y][x][0] > max_row_size
      max_row_size = trees[y][x][0]
    end
  end
end

puts trees.map { |ty| ty.map { |tx| tx[1...].all?(false) }.count(false) }.sum
