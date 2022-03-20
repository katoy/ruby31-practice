# frozen_string_literal: true

require_relative './test_helper'
require_relative '../lib/rainbowable'

class RainbowableTest < Minitest::Test
  def setup
    String.include Rainbowable
    Array.include Rainbowable
  end

  def test_rainbow
    expected = "\e[31mH\e[32me\e[33ml\e[34ml\e[35mo\e[36m,\e[31m \e[32mw\e[33mo\e[34mr\e[35ml\e[36md\e[31m!\e[0m"
    assert_equal expected, 'Hello, world!'.rainbow

    expected = "\e[31m[\e[32m1\e[33m,\e[34m \e[35m2\e[36m,\e[31m \e[32m3\e[33m]\e[0m"
    assert_equal expected, [1, 2, 3].rainbow
  end

  def test_rainbow_with_color_ary
    expected = "\e[31ma\e[32mb\e[31mc\e[32md\e[31me\e[32mf\e[0m"
    assert_equal expected, 'abcdef'.rainbow([31, 32])

    expected = "\e[31ma\e[32mb\e[33mc\e[34md\e[35me\e[36mf\e[0m"
    assert_equal expected, 'abcdef'.rainbow([])

    assert_equal expected, 'abcdef'.rainbow(nil)
  end
end
