require 'json'
require 'paho-mqtt'

if ENV['RAILS_ENV'] != 'test' && defined?(::Rails::Server)
  ### Create client
  client = PahoMqtt::Client.new(
    host: ENV["MQTT_BROKER_HOST"],
    port: ENV["MQTT_BROKER_PORT"],
    persistent: true,
    reconnect_limit: -1
  )

  ### Callbacks
  client.on_message do |message|
    payload = JSON.parse(message.payload)

    if message.topic == 'green/record'
      node = Node.find_by(chip_id: payload['node_id'])

      if node
        Record.create(
          node: node,
          moisture: payload['moisture']
        )
      end
    end
  end

  ### Connect to the MQTT server
  client.connect

  ### Subscribe to topics
  client.subscribe("green/record", 2)
end