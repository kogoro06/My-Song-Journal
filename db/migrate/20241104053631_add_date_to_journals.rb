class AddDateToJournals < ActiveRecord::Migration[7.2]
  def change
    add_column :journals, :date, :date
  end
end
