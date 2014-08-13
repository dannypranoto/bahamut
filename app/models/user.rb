class User < ActiveRecord::Base
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

end
