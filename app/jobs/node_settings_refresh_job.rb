class NodeSettingsRefreshJob < ApplicationJob
  queue_as :default

  before_perform do |job|
    # Reschedule job for periodic execution
    self.class.set(wait: 1.day).perform_later
  end

  def perform
    client = PahoMqtt::Client.new(
      host: ENV["MQTT_BROKER_HOST"],
      port: ENV["MQTT_BROKER_PORT"]
    )
    client.connect
    Node.all.each do |node|
      client.publish(
        "green/settings/#{node.chip_id}",
        {
          min_moisture: node.min_moisture,
          max_moisture: node.max_moisture,
          max_pumping_time: node.max_pumping_time
        }.to_json,
        true,
        2
      )
    end
  end
end
