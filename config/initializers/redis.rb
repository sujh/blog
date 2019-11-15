REDIS = ConnectionPool::Wrapper.new(size: 5, timeout: 5) { Redis.new(host: Rails.application.config_for(:application).dig('redis', 'host')) }
