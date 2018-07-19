class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :ingredients, :unit, :measurement
  end
end
