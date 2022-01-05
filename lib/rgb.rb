# frozen_string_literal: true

def to_hex(r, g, b)
  [r, g, b].sum('#') do |n|
    n.to_s(16).rjust(2, '0')
  end
end

def to_ints(hex)
  hex.scan(/\w\w/).map(&:hex)
end

def to_hex2(r, g, b)
  raise(ArgumentError, 'Out of range') unless [r, g, b].all? { |x| x.between?(0, 255) }

  to_hex(r, g, b)
end

def to_ints2(hex)
  raise(ArgumentError, 'Invalid format') if hex.scan(/\A#[0-9a-fA-F]{6}\z/).size != 1

  hex.scan(/[0-9a-fA-F]{2}/).map(&:hex)
end
