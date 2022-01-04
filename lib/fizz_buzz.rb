# frozen_string_literal: true

def fizz_buzz(num)
  if (num % 15).zero?
    'Fizz Buzz'
  elsif (num % 3).zero?
    'Fizz'
  elsif (num % 5).zero?
    'Buzz'
  else
    num.to_s
  end
end

DATA = { 3 => 'Fizz', 5 => 'Buzz' }.freeze

def fizz_buzz2(num)
  ret = DATA.map { |d, v| v if (num % d).zero? }
            .compact.join(' ')

  return ret unless ret.empty?

  num.to_s
end
