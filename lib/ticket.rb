# frozen_string_literal: true

# Ticket
class Ticket
  attr_reader :fare, :stamped_at, :stamped2_at

  def initialize(fare)
    raise(ArgumentError, 'fare is negative') if fare.to_i.negative?

    @fare = fare
  end

  def stamp(name)
    raise(ArgumentError, 'alrady stamped') if @stamped_at

    @stamped_at = name
  end

  def stamp2(name)
    raise(ArgumentError, 'alrady stamped2') if @stamped2_at

    raise(ArgumentError, 'no stamped') unless @stamped_at

    @stamped2_at = name
  end
end
