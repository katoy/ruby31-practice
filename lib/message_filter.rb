# frozen_string_literal: true

# MessageFilter
class MessageFilter
  attr_reader :ng_words

  def initialize(*ng_words)
    # @ng_words = ng_words
    words = ng_words.select { |w| w.strip.length.positive? } # "" や "  " などを除外する
    @ng_words = words.sort.uniq
  end

  def detect?(text)
    @ng_words.any? { |w| text.include?(w) }
  end
end
