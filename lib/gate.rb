# frozen_string_literal: true

# Gate
class Gate
  attr_reader :name

  def initialize(name)
    @name = name
  end

  STATIONS = %i[umeda juso mikuni].freeze
  FARES = [120, 160, 190].freeze # 120: 入場料金
  GATES = STATIONS.map { |name| [name, Gate.new(name)] }.to_h.freeze

  def self.find(name)
    ret = GATES[name.to_sym]
    raise(ArgumentError, 'bad name') if ret.nil?

    ret
  end

  def enter(ticket)
    return false if ticket.stamped_at || ticket.stamped2_at

    ticket.stamp(@name)
  end

  def exit(ticket)
    return false if ticket.stamped_at.nil? || ticket.stamped2_at

    return false if ticket.fare < calc_fare(ticket)

    ticket.stamp2(@name)
  end

  def calc_fare(ticket)
    from = STATIONS.index(ticket.stamped_at)
    to = STATIONS.index(@name)
    distance = to - from
    distance *= -1 if distance.negative?
    ret = FARES[distance]
    raise(ArgumentError, 'illegal fare') if ret.to_i <= 0

    ret
  end

  private_class_method :new
end
