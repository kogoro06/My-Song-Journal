class AddUnconfirmedEmailToUsers < ActiveRecord::Migration[6.1]
  def change
    # unconfirmed_email カラムが存在しない場合のみ追加
    add_column :users, :unconfirmed_email, :string unless column_exists?(:users, :unconfirmed_email)
  end
end
