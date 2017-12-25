# frozen_string_literal: true

ActiveAdmin.register Category do
  actions :all
  permit_params :owner_id, :name
end

