# frozen_string_literal: true

# Gate
class Gate
  attr_writer :name

  STATIONS = %i[umeda juso mikuni].freeze
  FARES = [120, 160, 190].freeze # 129: 入場料金
  GATES = STATIONS.map do |name|
    gate = Gate.new
    gate.name = name
    [name, gate]
  end.to_h.freeze

  def self.find(name)
    ret = GATES[name.to_sym]
    raise(ArgumentError, 'bad name') if ret.nil?

    ret
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
    distance *= -1 if distance.negative?
    ret = FARES[distance]
    raise(ArgumentError, 'illegal fare') if ret.to_i <= 0

    ret
  end

  private_class_method :new
end
