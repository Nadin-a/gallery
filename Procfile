worker: rails s -p 3000
worker: sidekiq -L log/sidekiq.log
worker: bundle exec sidekiq -e production -C config/sidekiq.yml