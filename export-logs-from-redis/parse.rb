require 'json'
require 'redis'

config = JSON.parse(File.read('config.json'))
redis = Redis.new({
  host:     config['host'],
  port:     config['port'],
  password: config['password'],
})

fields = %w[
  time
  duration
  trace
  server_region
  protocol
  property_name
  status
  response_size
  header_size
  remote_addr
  request_method
  host
  uri
  user_agent
  referer
  content_type
  cache_status
  geo_continent
  geo_continent_code
  geo_country
  geo_country_code
]

puts fields.join(',')

redis.lrange('belugacdn', 0, -1).each do |log|
  parsed = JSON.parse(log)
  values = fields.map { |field| '"' + parsed[field] + '"' }
  puts values.join(',')
end
