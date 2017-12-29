# frozen_string_literal: true

module CategoriesHelper
  def set_cover
    if @category.cover.present?
      @category.cover
    else
      'https://hdwallsource.com/img/2014/6/mountain-peaks-wallpaper-hd-33593-34349-hd-wallpapers.jpg'
    end
  end
end
