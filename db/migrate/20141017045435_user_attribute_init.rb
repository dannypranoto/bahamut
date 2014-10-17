class UserAttributeInit < ActiveRecord::Migration
  def change
  	add_column :customers, :username, :string, :null => false
  	add_column :customers, :balance, :integer, default: 0
  	add_column :customers, :status_customer, :boolean , :default => true 
	add_column :customers, :status_increase_limit, :boolean , :default => false
  end
end
