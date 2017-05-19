class AddUniqueIndexForSpreeUserPhone < ActiveRecord::Migration[5.0]
  def change
    add_index :spree_users, :phone, :name => 'phone_idx_unique', :unique => true
  end
end
