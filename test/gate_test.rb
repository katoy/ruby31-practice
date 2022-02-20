# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/gate'
require_relative '../lib/ticket'

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

class GateTest < Minitest::Test
  def setup
    @umeda = Gate.find(:umeda)
    @juso = Gate.find(:juso)
    @mikuni = Gate.find(:mikuni)
  end

  def test_station_name_for_gate
    e = assert_raises ArgumentError do
      Gate.find(:xxx)
    end
    assert_equal e.message.include?('bad name'), true
  end

  def test_station_name_by_string
    assert Gate.find('umeda')
  end

  def test_disabled_new_for_gate
    assert_raises NoMethodError do
      Gate.new
    end
  end

  def test_disable_set_name_for_gate
    gate = Gate.find(:umeda)
    assert_raises NoMethodError do
      gate.name = :umeda
    end
  end

  def test_get_name_for_gate
    gate = Gate.find(:umeda)
    assert gate.name == :umeda
  end

  def test_negative_fare_ticket
    e = assert_raises ArgumentError do
      Ticket.new(-1)
    end
    assert_equal e.message.include?('fare is negative'), true
  end

  TRAVELS = {
    umeda: { umeda: 120, juso: 160, mikuni: 190 }.freeze,
    juso: { umeda: 160, juso: 120, mikuni: 160 }.freeze,
    mikuni: { umeda: 190, juso: 160, mikuni: 120 }.freeze
  }.freeze

  # ピッタリの金額のチケット
  def test_just_fere
    TRAVELS.each do |start, goals|
      goals.each do |goal, fare|
        ticket = Ticket.new(fare)
        gate_start = Gate.find(start)
        gate_goal = Gate.find(goal)

        gate_start.enter(ticket)
        assert gate_goal.exit(ticket), "#{gate_start.name} - #{gate_goal.name}: #{fare}"
      end
    end
  end

  # 1 円多い金額のチケット
  def test_more_fere
    TRAVELS.each do |start, goals|
      goals.each do |goal, fare|
        ticket = Ticket.new(fare + 1)
        gate_start = Gate.find(start)
        gate_goal = Gate.find(goal)

        gate_start.enter(ticket)
        assert gate_goal.exit(ticket), "#{gate_start.name} - #{gate_goal.name}: #{fare}"
      end
    end
  end

  # 1 円少ない金額のチケット
  def test_less_fere
    TRAVELS.each do |start, goals|
      goals.each do |goal, fare|
        ticket = Ticket.new(fare - 1)
        gate_start = Gate.find(start)
        gate_goal = Gate.find(goal)

        gate_start.enter(ticket)
        refute gate_goal.exit(ticket), "#{gate_start.name} - #{gate_goal.name}: #{fare}"
      end
    end
  end
end
