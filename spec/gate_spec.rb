# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/gate'
require_relative '../lib/ticket'

RSpec.describe 'Gate' do
  let(:umeda) { Gate.find(:umeda) }
  let(:juso) { Gate.find(:juso) }
  let(:mikuni) { Gate.find(:mikuni) }

  let(:ticket) { Ticket.new(200) }
  let(:ticket_one) { Ticket.new(1) }

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

  describe 'self.find' do
    context 'valid name' do
      it { expect(Gate.find('juso').nil?).to eq false }
    end

    context 'invalid name' do
      it do
        expect do
          Gate.find('x')
        end.to raise_error(ArgumentError, /bad name/)
      end
    end
  end

  describe 'enter' do
    context 'with unused ticke' do
      it { expect(juso.enter(ticket)).to eq [:juso] }
    end

    context 'with used ticke' do
      before { juso.enter(ticket) }

      it { expect(juso.enter(ticket)).to eq false }
    end
  end

  describe 'exit' do
    context 'with unused ticke' do
      it { expect(juso.exit(ticket)).to eq false }
    end

    context 'with used ticke' do
      before { juso.enter(ticket) }

      it { expect(mikuni.exit(ticket)).to eq [:juso, :mikuni] }
    end

    context 'with 料金不足のチケット' do
      before { juso.enter(ticket_one) }

      it { expect(mikuni.exit(ticket_one)).to eq false }
    end
  end

  describe 'calk_fare' do
  end
end
