require 'sidekiq/api'

Sidekiq::Extensions.enable_delay!
if Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379/0', namespace: "gallery_sidekiq_#{Rails.env}", size: 7 }
    schedule_file = 'config/schedule.yml'
    if File.exists?(schedule_file)
      p '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!INIT SIDEKIQ!!!'
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379/0', namespace: "gallery_sidekiq_#{Rails.env}", size: 1 }
  end
end

if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDISTOGO_URL']}
  end
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDISTOGO_URL'], size: 1}
  end
end
