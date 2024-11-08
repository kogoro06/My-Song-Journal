class AddConfirmableToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :confirmation_token, :string unless column_exists?(:users, :confirmation_token)
    add_column :users, :confirmed_at, :datetime unless column_exists?(:users, :confirmed_at)
    add_column :users, :confirmation_sent_at, :datetime unless column_exists?(:users, :confirmation_sent_at)

    # インデックスが存在しない場合のみ追加
    add_index :users, :confirmation_token, unique: true, name: "index_users_on_confirmation_token" unless index_exists?(:users, :confirmation_token, name: "index_users_on_confirmation_token")
  end
end
