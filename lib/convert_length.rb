# frozen_string_literal: true

UNITS = {
  m: 1.0,
  ft: 3.28,
  in: 39.37,

  mm: 1000.0,
  cm: 100.0,
  km: 0.001
}.freeze

def convert_length(length, from: :m, to: :m)
  raise(ArgumentError, 'Invalid unit name') if UNITS[from].nil? || UNITS[to].nil?

  return length if from == to

  (length / UNITS[from] * UNITS[to]).round(3)
end
