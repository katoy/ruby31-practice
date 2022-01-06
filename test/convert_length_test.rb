# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/convert_length'

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

class ConvertLengthTest < Minitest::Test
  def test_convert_length
    assert_equal 39.37, convert_length(1, from: :m, to: :in)
    assert_equal 0.381, convert_length(15, from: :in, to: :m)
    assert_equal 10_670.732, convert_length(35_000, from: :ft, to: :m)

    assert_equal 1000.0, convert_length(1, from: :m, to: :mm)
    assert_equal 100.0, convert_length(1, from: :m, to: :cm)
    assert_equal 0.001, convert_length(1, from: :m, to: :km)

    # from と to が同じ場合は、桁おちしない
    assert_equal 1.23456, convert_length(1.23456, from: :cm, to: :cm)

    # from と to が異なる場合は、桁おちする
    assert_equal 1.2346, convert_length(1.23456, from: :cm, to: :mm)

    # 引数の省略
    assert_equal 39.37, convert_length(1, to: :in)
    assert_equal 0.381, convert_length(15, from: :in)
    assert_equal 1, convert_length(1)

    # 単位名のチェック
    e = assert_raises ArgumentError do
      convert_length(1, from: :z, to: :m)
    end
    assert_equal e.message.include?('Invalid unit name'), true
    e = assert_raises ArgumentError do
      convert_length(1, from: :m, to: :z)
    end
    assert_equal e.message.include?('Invalid unit name'), true
  end
end
