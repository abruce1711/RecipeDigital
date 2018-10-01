class CreateRecipesTags < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes_tags do |t|
      t.references :tag, foreign_key: true
      t.references :recipe, foreign_key: true
    end
    add_index :recipes_tags, [:recipe_id, :tag_id]
  end
end
