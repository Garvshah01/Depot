class User < ApplicationRecord

  ADMIN_EMAIL = 'admin@depot.com'.freeze

  validates :name, presence: true, uniqueness: true
  has_secure_password
  validates :email, uniqueness: true, allow_nil: true
  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP
  }

  before_update :ensure_not_admin
  before_destroy :ensure_not_admin
  after_destroy :ensure_an_admin_remains
  after_create_commit :send_welcome_mail

  class Error < StandardError
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end

  def ensure_not_admin
    throw :abort unless self.email == ADMIN_EMAIL
  end

  def send_welcome_mail
    UserMailer.welcome_email(self).deliver_later
  end
end
