class AddWechatInfoToUserAuthenticationsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_user_authentications, :openid, :string, after: :uid
    add_column :spree_user_authentications, :nickname, :string, after: :openid
    add_column :spree_user_authentications, :sex, :string, after: :nickname
    add_column :spree_user_authentications, :language, :string, after: :sex
    add_column :spree_user_authentications, :city, :string, after: :language
    add_column :spree_user_authentications, :province, :string, after: :city
    add_column :spree_user_authentications, :country, :string, after: :province
    add_column :spree_user_authentications, :headimgurl, :string, after: :country
    add_column :spree_user_authentications, :unionid, :string, after: :openid

    add_index :spree_user_authentications, :openid, name: 'open_idx_unique', unique: true
    add_index :spree_user_authentications, :unionid, name: 'union_idx_unique', unique: true
  end
end