class AddPhoneNumberToSpreeUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_users, :phone, :string, after: :email
  end
end
