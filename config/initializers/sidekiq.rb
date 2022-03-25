sidekiq_config = { url: ENV['JOB_WORKER_URL'] }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config

  schedule_file = 'config/schedule.yml'
  if File.exist?(schedule_file) && Rails.env.production?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end

  Rails.application.config.after_initialize do
    MqttJob.perform_async
  end
end
