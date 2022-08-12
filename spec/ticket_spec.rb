# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/ticket'

RSpec.describe Ticket do
  describe 'initializer' do
    it 'Error when fair < 0' do
      expect do
        Ticket.new(-1)
      end.to raise_error(ArgumentError, /fare is negative/)
    end

    it 'OK if fair > 0' do
      t = Ticket.new(1)
      expect(t.nil?).to eq false
    end
  end

  # unused?
  # using?
  # used?
  # stamp(name)
  # entered_st
end
