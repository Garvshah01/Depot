class User < ApplicationRecord

  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  validates :email, uniqueness: true, allow_nil: true
  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP
  }
  after_create :send_welcome_mail
  around_update :ensure_not_admin
  around_destroy :ensure_not_admin
  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end

  def ensure_not_admin
    yield unless self.email == 'admin@depot.com'
  end

  def send_welcome_mail
    UserMailer.with(user: self).welcome_email.deliver_now
  end
end
