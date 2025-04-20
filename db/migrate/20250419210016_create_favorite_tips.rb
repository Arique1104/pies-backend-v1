class CreateFavoriteTips < ActiveRecord::Migration[8.0]
  def change
    create_table :favorite_tips do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reflection_tip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
