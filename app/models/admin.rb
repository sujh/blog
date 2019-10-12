class Admin < ApplicationRecord

  attr_accessor :password

  before_create :salt_password

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :name, :password
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

  private

    def salt_password
      self.salt = Time.now.to_f
      self.password_salted = Admin.generate_digest(password, salt)
    end

end
