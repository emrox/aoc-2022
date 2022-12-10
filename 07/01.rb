# frozen_string_literal: true

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n")

folders = {
  '/' => 0
}

current_folder = []
max_total_size = 100_000

total_disk_space = 70_000_000
space_to_free = 30_000_000

input.each do |line|
  if line.start_with?('$ cd')
    folder = line.split(' ')[2]

    if folder == '/'
      current_folder = ['/']
    elsif folder == '..'
      current_folder.pop
    else
      current_folder.push(folder)
      folders[current_folder.join('/')] = 0 unless folders[current_folder.join('/')]
    end
  elsif file = line.match(/^([0-9]+)/)
    current_folder.each_index do |folder_index|
      folders[current_folder[0..folder_index].join('/')] += file[0].to_i
    end
  end
end

puts folders.values.select { |v| v <= max_total_size }.sum

all_used_space = folders['/']
dir_size_needed = all_used_space - (total_disk_space - space_to_free)

puts folders.values.select { |v| v > dir_size_needed }.min
