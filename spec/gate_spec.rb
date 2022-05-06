# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/gate'
require_relative '../lib/ticket'

RSpec.describe 'Gate' do
  let(:umeda) { Gate.find(:umeda) }
  let(:juso) { Gate.find(:juso) }
  let(:mikuni) { Gate.find(:mikuni) }

  describe 'Umeda to Juso' do
    it 'fare is not enough' do
      ticket = Ticket.new(150)
      umeda.enter(ticket)
      expect(juso.exit(ticket)).to be_falsey
    end

    it 'fare is enough' do
      ticket = Ticket.new(190)
      umeda.enter(ticket)
      expect(juso.exit(ticket)).to be_truthy
    end
  end

  describe 'Umeda to Mikuni' do
    context 'fare is not enough' do
      it 'is NG' do
        ticket = Ticket.new(150)
        umeda.enter(ticket)
        expect(mikuni.exit(ticket)).to be_falsey
      end
    end
    context 'fare is enough' do
      it 'is OK' do
        ticket = Ticket.new(190)
        umeda.enter(ticket)
        expect(mikuni.exit(ticket)).to be_truthy
      end
    end
  end

  describe 'Juso to Mikuni' do
    it 'is NG' do
      ticket = Ticket.new(150)
      juso.enter(ticket)
      expect(mikuni.exit(ticket)).to be_falsey
    end
  end
end
