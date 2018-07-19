class AddUnitToIngredient < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :unit, :string
  end
end
