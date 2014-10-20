class Customer < ActiveRecord::Base

  validates_uniqueness_of :username
  validates :username, length: { in: 4..20 }
  validates :username, format: { with: /\A[a-zA-Z0-9._]+\Z/ }

  validates :password, length: {minimum: 8}

  validate :password_complexity

  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).+$/)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

 def email=(address)
    if new_record?
      write_attribute(:email, address)
    else
      raise 'email is immutable!'
    end
  end

  #RETURN THE BALANCE LIMIT OF CURRENT USER
  #Limit balance for unincreased limit is Rp 1.000.000
  #Limit balance for increased limit is Rp 5.000.000
  def get_balance_limit
    if status_increase_limit
      return 5000000
    else
      return 1000000
    end
  end 
end
