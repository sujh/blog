class Admin < ApplicationRecord

  attr_accessor :password

  before_create :salt_password

  validates_presence_of :name, :password

  class << self

    def generate_digest(passwd, salt)
      Digest::MD5.hexdigest(Digest::MD5.hexdigest(passwd) + salt + 'blog')
    end

  end

  def authenticated?(str)
    password_salted == Admin.generate_digest(str, salt)
  end

  private

    def salt_password
      self.salt = Time.now.to_f
      self.password_salted = Admin.generate_digest(password, salt)
    end

end