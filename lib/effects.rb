# frozen_string_literal: true

# Effects
module Effects
  def self.reverse
    lambda do |words|
      raise(ArgumentError, 'given nil') if words.nil?

      words.split(' ').map(&:reverse).join(' ')
    end
  end

  def self.echo(rate)
    lambda do |words|
      raise(ArgumentError, 'given nil') if words.nil?

      words.each_char.map { |c| c == ' ' ? c : c * rate }.join
    end
  end

  def self.loud(level)
    lambda do |words|
      raise(ArgumentError, 'given nil') if words.nil?

      words.split(' ').map { |word| word.upcase + '!' * level }.join(' ')
    end
  end
end
