class AddArtistNameToJournals < ActiveRecord::Migration[7.2]
  def change
    add_column :journals, :artist_name, :string
  end
end
