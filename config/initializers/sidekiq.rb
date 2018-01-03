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
    config.redis = { url: ENV['REDISTOGO_URL'], size: 1 }
  end

  Sidekiq.configure_server do |config|
    pool_size = ENV['SIDEKIQ_DB_POOL'] || (Sidekiq.options[:concurrency] + 2)
    config.redis = { url: ENV['REDISTOGO_URL'], size: pool_size }

    Rails.application.config.after_initialize do
      Rails.logger.info("DB Connection Pool size for Sidekiq Server before disconnect is: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
      ActiveRecord::Base.connection_pool.disconnect!

      ActiveSupport.on_load(:active_record) do
        db_config = Rails.application.config.database_configuration[Rails.env]
        db_config['reaping_frequency'] = ENV['DATABASE_REAP_FREQ'] || 10 # seconds
        db_config['pool'] = pool_size
        ActiveRecord::Base.establish_connection(db_config)
        Rails.logger.info("DB Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
      end
    end
  end
end