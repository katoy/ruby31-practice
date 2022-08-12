# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'
require 'time'

# Weather
class Weather
  def self.weather(code)
    data = api(code)
    return data if data[0].nil?

    ts = data[0][:timeSeries][0][:timeDefines]
    data[0][:timeSeries][0][:areas].map do |area|
      # name = data[0][:timeSeries][0][:areas][idx][:area][:name]
      min_temp = data[1][:tempAverage][:areas][0][:min]
      max_temp = data[1][:tempAverage][:areas][0][:max]

      ts.map.with_index do |t, idx|
        {
          name: area[:area][:name],
          info: {
            time: Time.parse(t).strftime('%Y%m%d %T'),
            code: area[:weatherCodes][idx],
            weather: area[:weathers][idx],
            wind: area[:winds][idx],
            wave: area[:waves][idx],
            temp_min: min_temp,
            temp_max: max_temp
          }
        }
      end
    end
  end

  def self.api(code)
    url = "https://www.jma.go.jp/bosai/forecast/data/forecast/#{code}.json"
    data = Net::HTTP.get(URI.parse(url))
    JSON.parse(data, symbolize_names: true)
  rescue JSON::ParserError => e
    { error: e.message }
  end
end

if $PROGRAM_NAME == __FILE__
  # See https://zenn.dev/inoue2002/articles/2e07da8d0ca9ca
  #   気象庁APIから天気予報を取得する際のエリアコード一覧

  # code = '020000' # 青森
  code = '130000' # 東京
  # code = '110000' # 埼玉
  # code = '260000' # 京都
  # code = '471000' # 沖縄
  # code = '999999' # 不正な指定

  puts Weather.weather(code)

end
