class User < ActiveRecord::Base
  before_create :create_remember_token
  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A[+0]+[\d]+\z/

  validates :name,  presence: true,
                    length: { maximum: 50 }
  validates :email, presence: true,
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password,  presence:true,
                        length: { minimum: 6 }
  validates :phone_number,  presence: true,
                            format: { with: VALID_PHONE_REGEX },
                            length: { minimum: 9, maximum: 17}

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end
