class Post < ApplicationRecord

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  CACHE_KEYS = { trashes_num: 'post_trashes_num', posts_num: 'posts_num' }

  validates_presence_of :title, :content

  has_one :draft, class_name: 'PostDraft', dependent: :destroy

  scope :undeleted, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  before_save :clear_cache
  after_destroy { Rails.cache.delete(CACHE_KEYS[:trashes_num]) }

  class << self

    def cached_undeleted_count
      Rails.cache.fetch(CACHE_KEYS[:posts_num]) { self.undeleted.count }
    end

    def cached_deleted_count
      Rails.cache.fetch(CACHE_KEYS[:trashes_num]) { self.deleted.count }
    end

  end

  def act_as_deleted
    update(deleted_at: Time.now)
  end

  def renew
    update(deleted_at: nil)
  end

  def as_indexed_json(options)
    as_json(only: [:title, :content])
  end

  private

    def clear_cache
      if new_record?
        Rails.cache.delete(CACHE_KEYS[:posts_num])
      elsif deleted_at_changed?
        CACHE_KEYS.each_value { |v| Rails.cache.delete(v) }
      end
    end

end