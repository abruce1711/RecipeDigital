class AddColumnsToIngredients < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :type, :string
    add_column :ingredients, :amount, :integer
  end
end
