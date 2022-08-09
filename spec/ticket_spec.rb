# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/ticket'

RSpec.describe 'Ticket' do
  context 'initializer' do
    it 'erro when fair < 0' do
      expect do
        Ticket.new(-1)
      end.to raise_error(ArgumentError, /fare is negative/)
    end

    it 'OK if fair > 0' do
      t = Ticket.new(1)
      expect(t.nil?).to eq false
    end
  end
end
