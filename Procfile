worker: rails s -p 3000
sidekiq: sidekiq -L log/sidekiq.log

web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -e production -C config/sidekiq.yml