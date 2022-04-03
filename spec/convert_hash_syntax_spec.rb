# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/convert_hash_syntax'

RSpec.describe 'Convert hash syntax' do
  def x_eval(v)
    eval(v)
  end

  describe 'convert_hash_syntax' do
    context 'some json' do
      let(:old_syntax) do
        <<~TEXT
          {
          :name => 'Alice',
          :age=>20,
          :gender  =>  :female
          }
        TEXT
      end
      let(:expected) do
        <<~TEXT
          {
          name: 'Alice',
          age: 20,
          gender: :female
          }
        TEXT
      end
      it 'converts old syntax to new syntax' do
        expect(convert_hash_syntax(old_syntax)).to eq expected
        expect(x_eval(old_syntax)).to eq x_eval(expected)
      end
    end

    context 'empty json' do
      let(:old_syntax) do
        <<~TEXT
          {
          }
        TEXT
      end
      let(:expected) do
        <<~TEXT
          {
          }
        TEXT
      end
      it 'converts old syntax to new syntax' do
        expect(convert_hash_syntax(old_syntax)).to eq expected
        expect(x_eval(old_syntax)).to eq x_eval(expected)
      end
    end

    context 'nested json' do
      let(:old_syntax) do
        <<~TEXT
          {
            :name => {
              :first => 'kato'
            },
            :info => { :email    => 'foo@example.com' }
          }
        TEXT
      end
      let(:expected) do
        <<~TEXT
          {
            name: {
              first: 'kato'
            },
            info: { email: 'foo@example.com' }
          }
        TEXT
      end
      it 'converts old syntax to new syntax' do
        expect(convert_hash_syntax(old_syntax)).to eq expected
        expect(x_eval(old_syntax)).to eq x_eval(expected)
      end
    end

    context 'convert_hash_syntax_str' do
      let(:old_syntax) do
        <<~TEXT
          {
            :name => ':x => x'
          }
        TEXT
      end
      let(:expected) do
        <<~TEXT
          {
            name: 'x: x'
          }
        TEXT
      end
      it 'converts old syntax to new syntax' do
        # TODO: value 中も変換されてしまう。
        expect(convert_hash_syntax(old_syntax)).to eq expected
        # TODO: value 中も変換されてしまう。
        expect(x_eval(old_syntax)).not_to eq x_eval(expected)
      end
    end
  end

  describe 'convert_hash_syntax2' do
    context 'some json' do
      let(:old_syntax) do
        <<~TEXT
          {
            :name => 'Alice',
            :age=>20,
            :gender  =>  :female
          }
        TEXT
      end
      let(:expected) do
        <<~TEXT
          {
            name: 'Alice',
            age: '20',
            gender: 'female',
          }
        TEXT
      end
      it 'converts old syntax to new syntax' do
        expect(convert_hash_syntax2(old_syntax)).to eq expected
        # 数値が文字列に変換されてしまう
        expect(x_eval(old_syntax)).not_to eq x_eval(expected)
      end
    end

    context 'empty json' do
      let(:old_syntax) do
        <<~TEXT
          {
          }
        TEXT
      end
      let(:expected) do
        <<~TEXT
          {
          }
        TEXT
      end
      it 'converts old syntax to new syntax' do
        expect(convert_hash_syntax2(old_syntax)).to eq expected
        expect(x_eval(old_syntax)).to eq x_eval(expected)
      end
    end

    context 'nested json' do
      let(:old_syntax) do
        <<~TEXT
          {
            :name => {
              :first => 'kato'
            },
            :info => { :email    => 'foo@example.com' }
          }
        TEXT
      end
      let(:expected) do
        <<~TEXT
          {
            name: {
              first: 'kato',
            },
            info: {
              email: 'foo@example.com',
            },
          }
        TEXT
      end
      it 'converts old syntax to new syntax' do
        expect(convert_hash_syntax2(old_syntax)).to eq expected
        expect(x_eval(old_syntax)).to eq x_eval(expected)
      end
    end

    context 'convert_hash_syntax_str' do
      let(:old_syntax) do
        <<~TEXT
          {
            :name => ':x => x'
          }
        TEXT
      end
      let(:expected) do
        <<~TEXT
          {
            name: ':x => x',
          }
        TEXT
      end
      it 'converts old syntax to new syntax' do
        expect(convert_hash_syntax2(old_syntax)).to eq expected
        expect(x_eval(old_syntax)).to eq x_eval(expected)
      end
    end
  end
end
