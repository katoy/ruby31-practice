# frozen_string_literal: true

source 'https://rubygems.org'

gem 'debug'
gem 'fastri'
gem 'ruby-debug-ide'
# gem 'debase'
gem 'rcodetools'

gem 'faker'

group :development do
  gem 'rubocop'
end

group :test do
  # 必須
  gem 'minitest'
  # gem 'minitest-rails'
  # gem 'minitest-rails-capybara' # capybaraで結合テストできるようにする

  gem 'rspec'

  # レポートの書式を変更する
  gem 'minitest-reporters' # テスト結果の表示を整形

  # 機能追加系
  gem 'minitest-stub_any_instance' # メソッドmockを追加できる様にする

  gem 'minitest-bang' # let!文のサポートを追加

  gem 'factory_girl' # DBのデータのモックを作成

  gem 'simplecov', require: false
  gem 'simplecov-cobertura'

  gem 'slack-notifier'

  gem 'vcr'
  gem 'webmock'

  gem 'activesupport'
end
