class UserAttributeInit < ActiveRecord::Migration
  def change
  	add_column :customers, :username, :string, :null => false
  	add_column :customers, :balance, :integer, default: 0
  	add_column :customers, :status, :integer

  end
end
