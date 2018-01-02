Sidekiq::Extensions.enable_delay!

if Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379/0', namespace: "gallery_sidekiq_#{Rails.env}" }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379/0', namespace: "gallery_sidekiq_#{Rails.env}" }
  end
end
if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { size: 3, url: 'https://vast-temple-36975.herokuapp.com', namespace: 'gallery' }
  end
end