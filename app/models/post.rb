class Post < ApplicationRecord

  MAX_TAGS = 3

  include Elasticsearch::Model

  after_commit(on: :create) { ElasticsearchIndexer.perform_async(Post, id, :index) }
  after_commit(on: :update) { ElasticsearchIndexer.perform_async(Post, id, :update) }
  after_destroy { ElasticsearchIndexer.perform_async(Post, id, :delete) }

  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 20000 }

  has_one :draft, class_name: 'PostDraft', dependent: :destroy
  belongs_to :admin
  has_many :tags, dependent: :destroy

  scope :with_tag, ->(value) { joins(:tags).where('tags.value = ?', value) }

  accepts_nested_attributes_for :tags, limit: MAX_TAGS, allow_destroy: true, reject_if: :all_blank

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :title, type: :text
      indexes :content, type: :text
      indexes :admin_id, type: :long
      indexes :is_public, type: :boolean
    end
  end

  def as_indexed_json(options)
    as_json(only: [:title, :content, :admin_id, :is_public])
  end

end