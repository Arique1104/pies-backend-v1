class CreateTipRatings < ActiveRecord::Migration[8.0]
  def change
    create_table :tip_ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reflection_tip, null: false, foreign_key: true
      t.boolean :helpful

      t.timestamps
    end
  end
end
