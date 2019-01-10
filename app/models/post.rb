class Post < ApplicationRecord

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: 'false' do
      indexes :title, index: 'not_analyzed'
      indexes :content, index: 'not_analyzed'
    end
  end

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

  private

    def clear_cache
      if new_record?
        Rails.cache.delete(CACHE_KEYS[:posts_num])
      elsif deleted_at_changed?
        CACHE_KEYS.each_value { |v| Rails.cache.delete(v) }
      end
    end

end