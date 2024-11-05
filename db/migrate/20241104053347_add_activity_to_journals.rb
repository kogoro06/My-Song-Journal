class AddActivityToJournals < ActiveRecord::Migration[7.2]
  def change
    add_column :journals, :activity, :json
  end
end
