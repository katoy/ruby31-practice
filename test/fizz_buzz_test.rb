# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/fizz_buzz'

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new
# $ export MINITEST_REPORTER=ProgressReporter
#
# Minitest::Reporters::DefaultReporter  # => Redgreen-capable version of standard Minitest reporter
# Minitest::Reporters::SpecReporter     # => Turn-like output that reads like a spec
# Minitest::Reporters::ProgressReporter # => Fuubar-like output with a progress bar
# Minitest::Reporters::RubyMateReporter # => Simple reporter designed for RubyMate
# Minitest::Reporters::RubyMineReporter # => Reporter designed for RubyMine IDE and TeamCity CI server
# Minitest::Reporters::JUnitReporter    # => JUnit test reporter designed for JetBrains TeamCity
# Minitest::Reporters::MeanTimeReporter # => Produces a report summary showing the slowest running tests
# Minitest::Reporters::HtmlReporter     # => Generates an HTML report of the t

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
