REDIS_URL = ENV['REDIS_URL'] || 'redis://localhost:6379'
Rails.application.config.session_store :redis_store, servers: REDIS_URL
