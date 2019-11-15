Elasticsearch::Model.client = Elasticsearch::Client.new host: Rails.application.config_for(:application).dig('elasticsearch', 'host')
