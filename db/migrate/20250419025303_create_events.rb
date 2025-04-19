class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :date
      t.string :location
      t.bigint :created_by_membership_id
      t.foreign_key :memberships, column: :created_by_membership_id
      t.timestamps
    end
  end
end
