if Rails.env == 'production'
  redis = Redis.new(url: ENV["REDISCLOUD_URL"])
else
  redis = Redis.new
end

