# frozen_string_literal: true

# log formatter
module LogFormatter
  # TODO: メモリーに収まりきれない量のログの書式変換もできるようにする事
  def self.format_log(log_data)
    log_data.map do |log|
      case log
      in {request_id:, path:, status: 404 | 500 => status, error:}
        "[ERROR] request_id=#{request_id}, path=#{path}, status=#{status}, error=#{error}"
      in {request_id:, path:, duration: 1000.. => duration}
        "[WARN] request_id=#{request_id}, path=#{path}, duration=#{duration}"
      in {request_id:, path:}
        "[OK] request_id=#{request_id}, path=#{path}"
      else
        "[???] #{log}"
      end
    end.join("\n")
  end
end
