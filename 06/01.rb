# frozen_string_literal: true

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n")[0]

[4, 14].each do |marker_length|
	(input.length - marker_length).times do |pos|
		marker = input[pos...pos+marker_length]

		if marker.split('').uniq.length != marker.length
			next
		end

		puts "#{pos + marker_length} #{marker.inspect}"
		break
	end
end
