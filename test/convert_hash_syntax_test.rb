# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/convert_hash_syntax'

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

class ConvertHashSyntaxTest < Minitest::Test
  def x_eval(x)
    eval(x)
  end

  def test_convert_hash_syntax
    old_syntax = <<~TEXT
      {
        :name => 'Alice',
        :age=>20,
        :gender  =>  :female
      }
    TEXT

    expected = <<~TEXT
      {
        name: 'Alice',
        age: 20,
        gender: :female
      }
    TEXT

    assert_equal expected, convert_hash_syntax(old_syntax)
    assert_equal x_eval(expected), x_eval(convert_hash_syntax(old_syntax))
  end

  def test_convert_hash_syntax_empty
    old_syntax = <<~TEXT
      {
      }
    TEXT

    expected = <<~TEXT
      {
      }
    TEXT

    assert_equal expected, convert_hash_syntax(old_syntax)
    assert_equal x_eval(expected), x_eval(convert_hash_syntax(old_syntax))
  end

  def test_convert_hash_syntax_nest
    old_syntax = <<~TEXT
      {
        :name => {
          :first => 'kato'
        },
        :info => { :email    => 'foo@example.com' }
      }
    TEXT

    expected = <<~TEXT
      {
        name: {
          first: 'kato'
        },
        info: { email: 'foo@example.com' }
      }
    TEXT

    assert_equal expected, convert_hash_syntax(old_syntax)
    assert_equal x_eval(expected), x_eval(convert_hash_syntax(old_syntax))
  end

  def test_convert_hash_syntax_str
    old_syntax = <<~TEXT
      {
        :name => ':x => x'
      }
    TEXT

    expected = <<~TEXT
      {
        name: 'x: x'
      }
    TEXT

    # TODO: value 中も変換されてしまう。
    assert_equal expected, convert_hash_syntax(old_syntax)
    # assert_equal eval(expected), eval(convert_hash_syntax(old_syntax))
  end

  def test_convert_hash_syntax2
    old_syntax = <<~TEXT
      {
        :name => ':x => x'
      }
    TEXT

    expected = <<~TEXT
      {
        name: ':x => x',
      }
    TEXT

    assert_equal expected, convert_hash_syntax2(old_syntax)
    # assert_equal eval(expected), eval(convert_hash_syntax2(old_syntax))
    assert_equal x_eval(expected), x_eval(old_syntax)
  end

  def test_convert_hash_syntax2_empty
    old_syntax = <<~TEXT
      {
      }
    TEXT

    expected = <<~TEXT
      {
      }
    TEXT

    assert_equal expected, convert_hash_syntax2(old_syntax)
    assert_equal x_eval(expected), x_eval(convert_hash_syntax2(old_syntax))
  end

  def test_convert_hash_syntax2_nest
    old_syntax = <<~TEXT
      {
        :name => {
          :first => 'kato'
        },
        :info => { :email    => 'foo@example.com' }
      }
    TEXT

    expected = <<~TEXT
      {
        name: {
          first: 'kato',
        },
        info: {
          email: 'foo@example.com',
        },
      }
    TEXT

    assert_equal expected, convert_hash_syntax2(old_syntax)
    assert_equal x_eval(expected), x_eval(convert_hash_syntax2(old_syntax))
  end
end
