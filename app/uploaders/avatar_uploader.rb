# frozen_string_literal: true

require 'fog/aws'
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [30, 30]
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def content_type_whitelist
    %r{image\/}
  end
end
