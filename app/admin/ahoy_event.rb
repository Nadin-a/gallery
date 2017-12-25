# frozen_string_literal: true

ActiveAdmin.register Ahoy::Event do
  menu false
  index do
    id_column
    column :name
    column :properties
  end
end
