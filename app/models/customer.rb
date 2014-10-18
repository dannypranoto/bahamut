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
end
