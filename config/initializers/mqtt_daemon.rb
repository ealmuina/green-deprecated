require 'json'
require 'paho-mqtt'

unless ENV['RAILS_ENV'] == 'test'
  ### Create a simple client with default attributes
  client = PahoMqtt::Client.new

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
  client.connect(ENV["MQTT_BROKER_HOST"], ENV["MQTT_BROKER_PORT"])

  ### Subscribe to topics
  client.subscribe("green/record", 2)
end