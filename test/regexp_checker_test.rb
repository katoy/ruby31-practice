# frozen_string_literal: true

require_relative './test_helper'
require_relative '../lib/regexp_checker'

require 'stringio'

# See
# https://qiita.com/jnchito/items/23f623cdb4bed67f17f8
# 正規表現チェッカープログラムのテストを自動化する
#
class RegexpCheckerTest < Minitest::Test
  def test_main_when_matched
    # ユーザーの入力値
    io = StringIO.new(
      "123-456-789\n" \
      "[1-6+\n" \
      "[1-6]+\n"
    )

    expected = [
      'Text?: ',
      'Pattern?: ',
      "Invalid pattern: premature end of char-class: /[1-6+/\n",
      'Pattern?: ',
      "Matched: '123', '456'\n"
    ].join

    assert_output(expected) do
      $stdin = io
      RegexpChecker.main
      $stdin = STDIN
    end
  end

  def test_main_when_not_matched
    # ユーザーの入力値
    io = StringIO.new(
      "abc-def-ghi\n" \
      "[1-6]+\n"
    )

    expected = [
      'Text?: ',
      'Pattern?: ',
      "Nothing matched.\n"
    ].join

    assert_output(expected) do
      $stdin = io
      RegexpChecker.main
      $stdin = STDIN
    end
  end
end
