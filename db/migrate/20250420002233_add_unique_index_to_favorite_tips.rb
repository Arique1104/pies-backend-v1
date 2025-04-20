class AddUniqueIndexToFavoriteTips < ActiveRecord::Migration[8.0]
  def change
    add_index :favorite_tips, [:user_id, :reflection_tip_id], unique: true
  end
end
