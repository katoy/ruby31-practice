# frozen_string_literal: true

# Gate
class Gate
  STATIONS = %i[umeda juso mikuni].freeze
  FARES = [160, 190].freeze

  def initialize(name)
    @name = name
  end

  def enter(ticket)
    ticket.stamp(@name)
  end

  def exit(ticket)
    fare = calc_fare(ticket)
    fare <= ticket.fare
  end

  def calc_fare(ticket)
    from = STATIONS.index(ticket.stamped_at)
    to = STATIONS.index(@name)
    distance = to - from
    ret = FARES[distance - 1]
    raise(ArgumentError, 'illegal fare') if ret.to_i <= 0

    ret
  end
end
