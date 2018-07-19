class ChangeAmountToBeFloatInIngredients < ActiveRecord::Migration[5.0]
  def change
    change_column :ingredients, :amount, :float
  end
end
