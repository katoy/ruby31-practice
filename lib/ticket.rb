# frozen_string_literal: true

# Ticket
class Ticket
  attr_reader :fare, :stamped_at

  def initialize(fare)
    raise(ArgumentError, 'fare is negative') if fare.to_i.negative?

    @fare = fare
  end

  def stamp(name)
    @stamped_at = name
  end
end
