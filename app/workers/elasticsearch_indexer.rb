class ElasticsearchIndexer
  include Sidekiq::Worker
  sidekiq_options queue: 'indexer', retry: 3

  def perform(klass, record_id, operation)
    logger.info [operation, "ID: #{record_id}"]
    klass = klass.is_a?(Class) || klass.constantize

    case operation.to_s
    when /index/
      klass.find(record_id).__elasticsearch__.index_document
    when /update/
      klass.find(record_id).__elasticsearch__.update_document
    when /delete/
      begin
        Elasticsearch::Model.client.delete(index: klass.index_name, type: klass.document_type, id: record_id)
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        logger.error "#{klass} not found, ID: #{record_id}"
      end
    else raise ArgumentError, "Unknown operation '#{operation}'"
    end
  end
end