class User < ApplicationRecord

  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  validates :email, uniqueness: true, allow_nil: true
  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP
  }

  class Error < StandardError
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end
end
