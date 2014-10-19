class ChangeCustomerNameToUsername < ActiveRecord::Migration
  def change
  	rename_column :customers,:customer_name, :username
  	add_index :customers,:username, :unique =>true
  end
end
