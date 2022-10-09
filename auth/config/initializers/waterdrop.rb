require 'water_drop'
require 'water_drop/sync_producer'

WaterDrop.setup do |config|
  config.deliver = true
  config.kafka.seed_brokers = ['kafka://127.0.0.1:9092']
end