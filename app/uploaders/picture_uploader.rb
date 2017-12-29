# frozen_string_literal: true

require 'fog/aws'
class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [2000, 2000]

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :show_thumb do
    process resize_to_limit: [1500, 1500]
  end

  version :thumb do
    process resize_to_fill: [600, 600]
  end

  version :preview_thumb do
    process resize_to_fill: [376, 180]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [100, 100]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def content_type_whitelist
    %r{image\/}
  end
end
