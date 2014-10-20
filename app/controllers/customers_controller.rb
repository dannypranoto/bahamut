class CustomersController < ApplicationController
	before_action :authenticate_customer!

	def transaction

	end

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

	def topup
		if request.post?
			topup_nominal = params[:topup][:amount].to_i

			#CHECKING CONDITION
			if topup_nominal <= 0
				redirect_to topup_customers_path,alert: "Invalid Nominal" and return
			end

			if current_customer.balance + topup_nominal > current_customer.get_balance_limit
				redirect_to topup_customers_path,alert: "Top up exceeds limit balance" and return
			end

			#sending top_up request
			request_body = {
				payment_type: "bank_transfer",
				bank_transfer: {
					bank: "permata"
				},
				transaction_details:{
					order_id: (rand*100000).to_i,
					gross_amount: topup_nominal
				},
				customer_details:{
					first_name: 'Danny',
					last_name: 'Pranoto',
					email: current_customer.email,
					phone: '+6283199440068'
				}
			}

			request_header = {
				:Authorization =>  'Basic ' + Base64.strict_encode64(Rails.application.secrets.vt_server_key + ':'),
				:Accept => 'application/json',
				:'Content-Type' => 'application/json'
			}

			url = Rails.application.secrets.vt_server_url

			#loop do
				#response = Excon.post(url,:body => request_body.to_json,:headers => request_header)
			#	break if response == 
			#end

			#binding.pry
			transfer_name = "permata_va_account"
			transfer_number = "111111111"

			redirect_to topup_success_customers_path({:transfer_name => transfer_name,:transfer_number => transfer_number}) and return
		end
	end

	def topup_success
		@transfer_name = params[:transfer_name]
		@transfer_number = params[:transfer_number]
	end
end
