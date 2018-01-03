web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -d -q mailer,5 -q default -e production