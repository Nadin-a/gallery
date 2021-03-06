require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
  if Rails.env.production?
    config.root = Rails.root.join('tmp') # adding these...
    config.cache_dir = 'carrierwave'
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
    # Configuration for Amazon S3
    provider: 'AWS',
    aws_access_key_id:  ENV['S3_ACCESS_KEY'],
    aws_secret_access_key: ENV['S3_SECRET_KEY'],
    region: ENV['S3_REGION']
    }
    config.fog_directory = ENV['S3_BUCKET']
    config.storage = :fog
  end
end

