# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/gate'
require_relative '../lib/ticket'

RSpec.describe Gate do
  let(:umeda) { Gate.find(:umeda) }
  let(:juso) { Gate.find(:juso) }
  let(:mikuni) { Gate.find(:mikuni) }
  let(:xxx) { Gate.send(:new, 'xxx') }

  let(:ticket) { Ticket.new(200) }
  let(:ticket_one) { Ticket.new(1) }

  let(:time_one) { Time.zone.parse('2022-10-01 12:13:14') }

  describe 'new' do
    context 'is private' do
      it do
        expect do
          Gate.new('xxx')
        end.to raise_error(NoMethodError)
      end
    end
  end

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
      it do
        ret = juso.enter(ticket)
        expect(ret.size).to eq 1
        expect(ret[0][:name]).to eq :juso
      end
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

      it do
        ret = mikuni.exit(ticket)
        expect(ret.size).to eq 2
        expect(ret[0][:name]).to eq(:juso)
        expect(ret[1][:name]).to eq(:mikuni)
      end
    end

    context 'with 料金不足のチケット' do
      before { juso.enter(ticket_one) }

      it { expect(mikuni.exit(ticket_one)).to eq false }
    end
  end

  describe 'calc_fare' do
    context 'juso to mikuni' do
      before { juso.enter(ticket) }

      it { expect(mikuni.calc_fare(ticket)).to eq 160 }
    end

    context 'mikuni to juso' do
      before { mikuni.enter(ticket) }

      it { expect(juso.calc_fare(ticket)).to eq 160 }
    end

    context 'juso to juso' do
      before { juso.enter(ticket) }

      it { expect(juso.calc_fare(ticket)).to eq 120 }
    end

    context 'juso to xxx' do
      before { juso.enter(ticket) }

      it do
        expect do
          xxx.calc_fare(ticket)
        end.to raise_error(ArgumentError, /illegal stamp: xxx/)
      end
    end

    context 'xxx to juxo' do
      before { xxx.enter(ticket) }

      it do
        expect do
          juso.calc_fare(ticket)
        end.to raise_error(ArgumentError, /illegal stamp: {:name=>:xxx/)
      end
    end

    context '乗車時間のチェック' do
      before { travel_to(time_one) { umeda.enter(ticket) } }

      context '乗車時間 == 0' do
        it do
          travel_to(time_one) do
            umeda.enter(ticket)
            expect do
              juso.calc_fare(ticket)
            end.to raise_error(ArgumentError, 'illegal time_stamp')
          end
        end
      end

      context '乗車時間 120 分' do
        it do
          travel_to(time_one + 2.hours) do
            expect(juso.calc_fare(ticket)).to eq 160
          end
        end
      end

      context '乗車時間 120 分 1 秒' do
        it do
          travel_to(time_one + 2.hours + 1.second) do
            expect do
              juso.calc_fare(ticket)
            end.to raise_error(ArgumentError, 'illegal time_stamp')
          end
        end
      end
    end
  end
end
