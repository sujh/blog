class Post < ApplicationRecord

  validates_presence_of :title, :content

  has_one :draft, class_name: 'PostDraft', dependent: :destroy

  scope :undeleted, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  def act_as_deleted
    update(deleted_at: Time.now)
  end

  def renew
    update(deleted_at: nil)
  end

end