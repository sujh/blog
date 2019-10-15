class Admin < ApplicationRecord

  attr_accessor :password

  before_create :salt_password

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, length: 3..20, on: :create
  validates :email, presence: true, uniqueness: true, format: { with: /\w+@\w+\.[a-z]+/ }

  has_many :posts
  has_many :drafts, class_name: 'PostDraft'

  class << self

    def generate_digest(passwd, salt)
      Digest::MD5.hexdigest(Digest::MD5.hexdigest(passwd) + salt + 'blog')
    end

  end

  def authenticated?(str)
    password_salted == Admin.generate_digest(str, salt)
  end

  def skill_list
    Array(skills&.split(','))
  end

  def tag_group
    posts.joins(:tags).group('tags.value').count
  end

  private

    def salt_password
      self.salt = Time.now.to_f
      self.password_salted = Admin.generate_digest(password, salt)
    end

end
