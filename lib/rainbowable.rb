# frozen_string_literal: true

# Rainbowable
module Rainbowable
  DEFAULT_COLORS = [31, 32, 33, 34, 35, 36].freeze

  @rainbow_colors = DEFAULT_COLORS

  def self.reset
    @rainbow_colors = DEFAULT_COLORS
  end

  def self.rainbow_colors=(color_ary)
    @rainbow_colors = dup_or_defult(color_ary, DEFAULT_COLORS).freeze
  end

  def self.rainbow_colors
    @rainbow_colors.dup
  end

  def rainbow(color_ary = nil)
    color_ary = Rainbowable.dup_or_defult(color_ary, Rainbowable.rainbow_colors)
    color_ary_size = color_ary.size

    str = to_s
    colors = (0...str.length).map { |idx| color_ary[idx % color_ary_size] }
    colors.zip(str.chars)
          .map { |color, ch| colored_char(color, ch) }
          .join + colored_char
  end

  private

  def colored_char(color = 0, char = '')
    "\e[#{color}m#{char}"
  end

  class << self
    def dup_or_defult(ary, default_colors)
      return default_colors if ary.nil? || ary.size.zero?

      ary.dup
    end
  end
end
