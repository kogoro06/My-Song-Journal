class AddImagePathToEmotions < ActiveRecord::Migration[7.2]
  def change
    add_column :emotions, :image_path, :string
  end
end
