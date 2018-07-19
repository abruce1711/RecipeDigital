class RenameImage < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipes, :image, :cover
  end
end
