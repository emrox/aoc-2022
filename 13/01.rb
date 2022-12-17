# frozen_string_literal: true

require 'json'

pairs = File.read(ARGV.first == 'd' ? 'debug' : 'input').split("\n\n").map do |pair|
  pair.split("\n").map { |line| JSON.parse(line) }
end

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

right_order_pairs = []
pairs.each_with_index do |pair, i|
  l, r = pair
  l, r = correct_types(l, r)

  right_order_pairs << i + 1 if check(l, r)
end

puts right_order_pairs.sum
