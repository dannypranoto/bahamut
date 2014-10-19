class CustomersController < ApplicationController
	before_action :authenticate_customer!

	def transfer
		if request.post?
			transferred_email = params[:transfer][:email]
			transferred_nominal = (params[:transfer][:nominal]).to_i
			
			#SEARCHING TRANSFERRED CUSTOMER
			transferred = Customer.find_by :email => transferred_email

			#CHECKING CONDITION
			#Redirect if customer not found
			#can't transfer to yourself
			#can't transfer invalid nominal
			#customer account balance can't have < 0 value
			#target account balance can't have > limit value
			if transferred.blank?
				redirect_to transfer_customers_path,alert: "Customer with that email not found" and return
			end

			if(transferred_email == current_customer.email)
				redirect_to transfer_customers_path,alert: "You can't transfer to yourself" and return
			end

			if transferred_nominal <= 0
				redirect_to transfer_customers_path,alert: "Invalid Nominal" and return
			end

			if(current_customer.balance - transferred_nominal < 0)
				redirect_to transfer_customers_path,alert: "Can't transfer , You don't have enough balance to transfer" and return
			end
			
			if(transferred.balance + transferred_nominal > transferred.get_balance_limit)
				redirect_to transfer_customers_path,alert: "Can't transfer , your target's limit is not sufficient" and return
			end

			#TRANSFERRING BALANCE
			current_customer.balance -= transferred_nominal
			current_customer.save

			transferred.balance += transferred_nominal
			transferred.save

			redirect_to transfer_customers_path,alert: "Transfer Success!" and return
		end
	end
end
