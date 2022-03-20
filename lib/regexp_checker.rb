# frozen_string_literal: true

# 小mんどラインアプリ
class RegexpChecker
  def main
    params = read_params
    matches = find_matches(text: params[:text], regexp: params[:regexp])
    puts show_matches(matches)
  end

  def read_params
    print 'Text?: '
    text = gets.chomp

    begin
      print 'Pattern?: '
      pattern = gets.chomp
      { text:, regexp: Regexp.new(pattern) }
    rescue RegexpError => e
      puts "Invalid pattern: #{e.message}"
      retry
    end
  end

  def find_matches(text: nil, regexp: nil)
    text.scan(regexp)
  end

  def show_matches(matches)
    return 'Nothing matched.' if matches.size.zero?

    "Matched: #{matches.map { |x| "'#{x}'" }.join(', ')}"
  end
end

# コマンドラインで実行する
RegexpChecker.new.main if __FILE__ == $PROGRAM_NAME
