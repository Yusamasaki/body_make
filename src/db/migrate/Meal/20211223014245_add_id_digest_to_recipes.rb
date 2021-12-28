class AddIdDigestToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :id_digest, :string
  end
end
