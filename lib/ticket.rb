# frozen_string_literal: true

# Ticket
class Ticket
  attr_reader :fare, :stampeds

  def initialize(fare)
    raise(ArgumentError, 'fare is negative') if fare.to_i.negative?

    @fare = fare
    @stampeds = []
  end

  def unused?
    @stampeds.size.zero?
  end

  def using?
    @stampeds.size == 1
  end

  def used?
    @stampeds.size >= 2
  end

  def stamp(name)
    @stampeds << { name: name.to_sym, time: Time.zone.now }
  end

  def entered_st
    @stampeds[0]
  end
end
