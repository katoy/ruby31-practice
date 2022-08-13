# frozen_string_literal: true

# See
#  https://qiita.com/jnchito/items/b1215a5d548cac4c7de6
#  RSpec の入門とその一歩先へ、第3イテレーション ～RSpec 3バージョン～

require_relative 'spec_helper'
require_relative '../lib/message_filter'

describe MessageFilter do
  shared_examples 'MessageFilter with argument "foo"' do |ng_words|
    it { expect(filter.detect?('hello from foo')).to eq true } # foo を発見
    it { expect(filter.detect?('hello, world!')).to eq false } # foo は見つからない
    it { expect(filter.detect?('')).to eq false } # 空テキストは false
    it { expect(filter.ng_words).to match_array ng_words } # 順番は無視して比較する
  end

  shared_examples 'MessageFilter without argument "foo"' do |ng_words|
    it { expect(filter.detect?('hello from foo')).to eq false } # foo の有無に関わらず false
    it { expect(filter.detect?('hello, world!')).to eq false }  # foo の有無に関わらず false
    it { expect(filter.detect?('')).to eq false } # 空テキストは false
    it { expect(filter.ng_words).to match_array ng_words } # 順番は無視して比較する
  end

  context 'with argument "foo"' do
    let(:filter) { MessageFilter.new('foo') }

    it_behaves_like 'MessageFilter with argument "foo"', ['foo']
  end

  context 'with argument "foo","bar"' do
    let(:filter) { MessageFilter.new('foo', 'bar') }

    it_behaves_like 'MessageFilter with argument "foo"', %w[bar foo]
    it { expect(filter.detect?('hello from bar')).to eq true }
  end

  context 'with argument "zoo","bar"' do
    let(:filter) { MessageFilter.new('zoo', 'bar') }

    it_behaves_like 'MessageFilter without argument "foo"', %w[bar zoo]
    it { expect(filter.detect?('hello from zoo')).to eq true }
  end

  context 'with argument "foo", "foo' do
    let(:filter) { MessageFilter.new('foo', 'foo') }

    it_behaves_like 'MessageFilter with argument "foo"', ['foo']
  end

  context 'with empty argument' do
    let(:filter) { MessageFilter.new }

    it_behaves_like 'MessageFilter without argument "foo"', []
    it { expect(filter.detect?('hello from zoo')).to eq false }
  end

  context 'with argument " "' do
    let(:filter) { MessageFilter.new(' ') }

    it_behaves_like 'MessageFilter without argument "foo"', []
    it { expect(filter.detect?('hello from zoo')).to eq false }
  end

  context 'with argument ""' do
    let(:filter) { MessageFilter.new('') }

    it_behaves_like 'MessageFilter without argument "foo"', []
    it { expect(filter.detect?('hello from zoo')).to eq false }
  end
end
