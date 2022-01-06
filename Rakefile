# frozen_string_literal: true

# 全てのテストを一括実行する場合は、
# $ rake
#
# 単独ファイルを debug する場合は
# $ bundle exec ruby -r debug test/convert_length_test.rb

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end

task default: :test
