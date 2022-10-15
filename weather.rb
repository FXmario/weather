require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'

url = URI("https://api.openweathermap.org/data/2.5/forecast?q=Jakarta&exclude=current,minutely,hourly,alerts&units=metric&appid=18d930f2e5deab90f6a3568398d91db1")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)

response = http.request(request).read_body
data = JSON.parse(response)

i = 0

puts "Weather Forecast: "

# Free account using 5 days 3 hours
while i < 40 do
	temp = data['list'][i]['main']['temp']
	date = DateTime.parse(data['list'][i]['dt_txt']).strftime("%a, %d %b %Y (%R)")
	puts "#{date}: #{temp}°C"
	i += 1
end
