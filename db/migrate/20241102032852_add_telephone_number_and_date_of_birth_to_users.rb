class AddTelephoneNumberAndDateOfBirthToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :telephone_number, :string
    add_column :users, :date_of_birth, :date
  end
end
