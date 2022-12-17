# frozen_string_literal: true

require 'json'

divider_packets = [[[2]], [[6]]]

input = File.read(ARGV.first == 'd' ? 'debug' : 'input').gsub(/\n+/, "\n").split("\n").map { |line| JSON.parse(line) }

def correct_types(l, r)
  return [l, r] if !l.is_a?(Array) && !r.is_a?(Array)

  l = [l] if !l.is_a?(Array) && !l.nil?
  r = [r] if !r.is_a?(Array) && !r.nil?

  [l&.size || 0, r&.size || 0].max.times do |i|
    l[i], r[i] = correct_types(l[i], r[i]) if l[i] && r[i]
  end

  [l&.compact, r&.compact]
end

def check(l, r)
  return true if !l && r
  return false if l && !r

  return if l == r
  return l < r unless l.is_a?(Array)

  [l.size, r.size].max.times do |i|
    return true if !l[i] && r[i]
    return false if l[i] && !r[i]

    res = check(l[i], r[i])
    return res if [true, false].include?(res)
  end

  nil
end

ordered = input.append(*divider_packets).sort do |l, r|
  l, r = correct_types(l, r)

  check(l, r) ? -1 : 1
end

ordered.each { |packet| puts packet.inspect }

first_divider_index = ordered.index(divider_packets.first) + 1
second_divider_index = ordered.index(divider_packets.last) + 1

puts first_divider_index * second_divider_index
