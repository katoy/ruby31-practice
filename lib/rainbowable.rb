# frozen_string_literal: true

# Rainbowable
module Rainbowable
  COLORS = [31, 32, 33, 34, 35, 36].freeze

  def rainbow(color_ary = nil)
    rainbow_colors =
      if color_ary.nil? || color_ary.size.zero?
        COLORS
      else
        color_ary
      end
    colors_size = rainbow_colors.size

    str = to_s
    colors = (0...str.length).map { |idx| rainbow_colors[idx % colors_size] }
    colors.zip(str.chars)
          .map { |color, ch| colored_char(color, ch) }
          .join + colored_char(0, '')
  end

  private

  def colored_char(color, char)
    "\e[#{color}m#{char}"
  end
end
