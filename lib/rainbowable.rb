# frozen_string_literal: true

# Rainbowable
module Rainbowable
  COLORS = [31, 32, 33, 34, 35, 36].freeze
  NUM_COLORS = COLORS.size

  def rainbow
    str = to_s
    colors = (0...str.length).map { |idx| nth_color(idx) }
    colors.zip(str.chars).map { |color, ch| colored_char(color, ch) }
          .join + colored_char(0, '')
  end

  private

  def colored_char(color, char)
    "\e[#{color}m#{char}"
  end

  def nth_color(idx)
    COLORS[idx % NUM_COLORS]
  end
end
