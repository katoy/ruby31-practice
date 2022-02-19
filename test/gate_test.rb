# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/gate'
require_relative '../lib/ticket'

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

class GateTest < Minitest::Test
  def setup
    @umeda = Gate.new(:umeda)
    @juso = Gate.new(:juso)
    @mikuni = Gate.new(:mikuni)
  end

  def test_umeda_to_juso
    ticket = Ticket.new(160)
    @umeda.enter(ticket)
    assert @juso.exit(ticket)
  end

  def test_umeda_to_mikuni_when_fare_is_not_enough
    ticket = Ticket.new(160)
    @umeda.enter(ticket)
    refute @mikuni.exit(ticket)
  end

  def test_umeda_to_mikuni_when_fare_is_enough
    ticket = Ticket.new(190)
    @umeda.enter(ticket)
    assert @mikuni.exit(ticket)
  end

  def test_mikuni_to_umeda_when_fare_is_enough
    ticket = Ticket.new(190)
    @mikuni.enter(ticket)
    assert @umeda.exit(ticket)
  end

  def test_juso_to_mikuni
    ticket = Ticket.new(160)
    @juso.enter(ticket)
    assert @mikuni.exit(ticket)
  end

  def test_mikuni_to_juso
    ticket = Ticket.new(160)
    @mikuni.enter(ticket)
    assert @juso.exit(ticket)
  end

  def test_umeda_to_umeda
    ticket = Ticket.new(120)
    @umeda.enter(ticket)
    assert @umeda.exit(ticket)
  end

  def test_umeda_to_umeda_when_fare_is_not_enough
    ticket = Ticket.new(100)
    @umeda.enter(ticket)
    refute @umeda.exit(ticket)
  end
end