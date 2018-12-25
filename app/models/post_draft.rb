class PostDraft < ApplicationRecord

  CACHE_KEYS = { num: 'post_drafts_num' }

  belongs_to :post, optional: true, inverse_of: 'draft'

  after_commit :clear_cache, on: [:create, :destroy]

  class << self

    def cached_count
      Rails.cache.fetch(CACHE_KEYS[:num]) { self.count }
    end

  end

  private

    def clear_cache
      Rails.cache.delete(CACHE_KEYS[:num])
    end

end