class Post < ApplicationRecord

  has_one :draft, class_name: 'PostDraft', dependent: :destroy

  validates_presence_of :title, :content

end