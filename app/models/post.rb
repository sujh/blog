class Post < ApplicationRecord

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates_presence_of :title, :content

  has_one :draft, class_name: 'PostDraft', dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  accepts_nested_attributes_for :tags, limit: 4

  #before_save :create_or_update_tags, if: ->{ (new_record? && tags.present?) || (!new_record? && self.tags_str_changed?) }

  def as_indexed_json(options)
    as_json(only: [:title, :content])
  end

  private

    def create_or_update_tags
      ori_tags = String(tags_str_was).split(',').uniq
      now_tags = tags_str.split(',').uniq
      deleted_tags = ori_tags - now_tags
      new_tags = now_tags - ori_tags

      new_tags.each do |tag_value|
        tag = Tag.find_by(value: tag_value)
        if tag
          self.tags << tag
        else
          self.tags.build(value: tag_value)
        end
      end

      deleted_tags.each do |tag_value|
        tag = Tag.find_by(value: tag_value)
        self.tags.destroy(tag) if tag
      end
    end

end