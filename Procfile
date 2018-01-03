web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -d -L log/sidekiq.log -t 25 -C config/sidekiq.yml -e production