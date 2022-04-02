# frozen_string_literal: true

require './spec/spec_helper'
require './lib/convert_length'

RSpec.describe 'Convert length' do
  it 'returns valid value' do
    expect(convert_length(1, from: :m, to: :in)).to eq 39.37
    expect(convert_length(15, from: :in, to: :m)).to eq 0.381
    expect(convert_length(35_000, from: :ft, to: :m)).to eq 10_670.732

    expect(convert_length(1, from: :m, to: :mm)).to eq 1000.0
    expect(convert_length(1, from: :m, to: :cm)).to eq 100.0
    expect(convert_length(1, from: :m, to: :km)).to eq 0.001

    # from と to が同じ場合は、桁おちしない
    expect(convert_length(1.23456, from: :cm, to: :cm)).to eq 1.23456

    # from と to が異なる場合は、桁おちする
    expect(convert_length(1.23456, from: :cm, to: :mm)).to eq 12.346

    # 引数の省略
    expect(convert_length(1, to: :in)).to eq  39.37
    expect(convert_length(15, from: :in)).to eq 0.381
    expect(convert_length(1)).to eq 1

    # 単位名のチェック
    expect do
      convert_length(1, from: :z, to: :m)
    end.to raise_error(ArgumentError, /Invalid unit name/)

    expect do
      convert_length(1, from: :m, to: :z)
    end.to raise_error(ArgumentError, /Invalid unit name/)
  end
end
