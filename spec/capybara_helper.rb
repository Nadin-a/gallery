# spec/capybara_helper.rb

require 'rails_helper'
require 'capybara/rspec'

# specify js driver
Capybara.javascript_driver = :selenium

# for testing ActionCable with Capybara we need a multithreaded webserver
Capybara.server = :puma

Capybara.register_server :puma do |app, port, host|
  require 'puma'
  Puma::Server.new(app).tap do |s|
    s.add_tcp_listener host, port
  end.run.join
end