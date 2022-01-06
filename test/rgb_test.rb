# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/rgb'

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new
class RgbTest < Minitest::Test
  def test_to_hex
    assert_equal '#000000', to_hex(0, 0, 0)
    assert_equal '#ffffff', to_hex(255, 255, 255)
    assert_equal '#043c78', to_hex(4, 60, 120)

    assert_equal '#1000102', to_hex(256, 1, 2) # TODO: エラーになるべき
  end

  def test_to_ints
    assert_equal [0, 0, 0], to_ints('#000000')
    assert_equal [255, 255, 255], to_ints('#ffffff')
    assert_equal [4, 60, 120], to_ints('#043c78')

    assert_equal [255, 255, 255], to_ints('#FFFFFF')
    assert_equal [4, 60, 120], to_ints('#043C78')

    assert_equal [0, 1, 2], to_ints('#G00102') # TODO: エラーになるべき
  end

  def test_to_hex2
    assert_equal '#000000', to_hex2(0, 0, 0)
    assert_equal '#ffffff', to_hex2(255, 255, 255)
    assert_equal '#043c78', to_hex2(4, 60, 120)

    e = assert_raises ArgumentError do
      to_hex2(256, 1, 2)
    end
    assert_equal e.message.include?('Out of range'), true
  end

  def test_to_ints2
    assert_equal [0, 0, 0], to_ints2('#000000')
    assert_equal [255, 255, 255], to_ints2('#ffffff')
    assert_equal [4, 60, 120], to_ints2('#043c78')

    assert_equal [255, 255, 255], to_ints2('#FFFFFF')
    assert_equal [4, 60, 120], to_ints2('#043C78')

    e = assert_raises ArgumentError do
      to_ints2('#G00102')
    end
    assert_equal e.message.include?('Invalid format'), true

    e = assert_raises ArgumentError do
      to_ints2('#FFF')
    end
    assert_equal e.message.include?('Invalid format'), true
  end
end
