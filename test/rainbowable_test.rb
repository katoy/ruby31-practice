# frozen_string_literal: true

require_relative './test_helper'
require_relative '../lib/rainbowable'

class RainbowableTest < Minitest::Test
  def setup
    String.include Rainbowable
    Array.include Rainbowable
    Rainbowable.reset
  end

  def test_rainbow
    expected = "\e[31mH\e[32me\e[33ml\e[34ml\e[35mo\e[36m,\e[31m \e[32mw\e[33mo\e[34mr\e[35ml\e[36md\e[31m!\e[0m"
    assert_equal expected, 'Hello, world!'.rainbow

    expected = "\e[31m[\e[32m1\e[33m,\e[34m \e[35m2\e[36m,\e[31m \e[32m3\e[33m]\e[0m"
    assert_equal expected, [1, 2, 3].rainbow
  end

  def test_rainbowable_defalt_colors
    expected = [31, 32, 33, 34, 35, 36]
    assert_equal expected, Rainbowable::DEFAULT_COLORS
  end

  def test_rainbowable_rainbow_colors_set_and_get
    expected_default = [31, 32, 33, 34, 35, 36]
    assert_equal expected_default, Rainbowable.rainbow_colors

    expected = [32, 31]
    Rainbowable.rainbow_colors = [32, 31]
    assert_equal expected, Rainbowable.rainbow_colors

    colors =  Rainbowable.rainbow_colors
    colors[0] = 1
    assert_equal expected, Rainbowable.rainbow_colors

    Rainbowable.reset
    assert_equal expected_default, Rainbowable.rainbow_colors

    colors =  Rainbowable.rainbow_colors
    colors[0] = 1
    assert_equal expected_default, Rainbowable.rainbow_colors
  end

  def test_rainbow_with_parameter
    expected_default = "\e[31ma\e[32mb\e[33mc\e[34md\e[35me\e[36mf\e[0m"
    expected = "\e[32ma\e[31mb\e[32mc\e[31md\e[32me\e[31mf\e[0m"

    assert_equal expected_default, 'abcdef'.rainbow([])
    assert_equal expected_default, 'abcdef'.rainbow(nil)
    assert_equal expected_default, 'abcdef'.rainbow
    assert_equal expected, 'abcdef'.rainbow([32, 31])
    assert_equal expected_default, 'abcdef'.rainbow

    Rainbowable.rainbow_colors = [32, 31]
    assert_equal expected, 'abcdef'.rainbow
    assert_equal expected, 'abcdef'.rainbow([])
    assert_equal expected, 'abcdef'.rainbow(nil)

    Rainbowable.reset
    assert_equal expected_default, 'abcdef'.rainbow
    assert_equal expected_default, 'abcdef'.rainbow([])
    assert_equal expected_default, 'abcdef'.rainbow(nil)
    assert_equal expected, 'abcdef'.rainbow([32, 31])
    assert_equal expected_default, 'abcdef'.rainbow
  end
end
