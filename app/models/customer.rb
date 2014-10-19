class Customer < ActiveRecord::Base
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
