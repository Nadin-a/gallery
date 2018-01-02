Sidekiq::Extensions.enable_delay!

Sidekiq.configure_server do |config|
  config.redis =
  {
  url: Redis.new(url: (ENV['REDISTOGO_URL'] || 'redis://localhost:6379/0')),
  namespace: "gallery_sidekiq_#{Rails.env}",
  size: 5
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
  url: Redis.new(url: (ENV['REDISTOGO_URL'] || 'redis://localhost:6379/0')),
  namespace: "gallery_sidekiq_#{Rails.env}",
  size: 1
  }
end

