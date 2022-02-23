# frozen_string_literal: true

require_relative './test_helper'
require_relative '../lib/fizz_buzz'
class FizzBuzzTest < Minitest::Test
  def test_fizz_buzz
    assert_equal '1', fizz_buzz(1)
    assert_equal '2', fizz_buzz(2)
    assert_equal 'Fizz', fizz_buzz(3)
    assert_equal '4', fizz_buzz(4)
    assert_equal 'Buzz', fizz_buzz(5)
    assert_equal 'Fizz', fizz_buzz(6)
    assert_equal 'Fizz Buzz', fizz_buzz(15)

    assert_equal 'Fizz Buzz', fizz_buzz(0)
    e = assert_raises NoMethodError do
      fizz_buzz('X')
    end
    assert_equal e.message.include?("undefined method `zero?'"), true
  end

  def test_fizz_buzz2
    assert_equal '1', fizz_buzz2(1)
    assert_equal '2', fizz_buzz2(2)
    assert_equal 'Fizz', fizz_buzz2(3)
    assert_equal '4', fizz_buzz2(4)
    assert_equal 'Buzz', fizz_buzz2(5)
    assert_equal 'Fizz', fizz_buzz2(6)
    assert_equal 'Fizz Buzz', fizz_buzz2(15)
    assert_equal '0', fizz_buzz2(0)
    assert_equal 'X', fizz_buzz2('X')
  end
end
