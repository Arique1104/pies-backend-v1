class AddUniqueIndexToDismissedKeywords < ActiveRecord::Migration[8.0]
  def change
    add_index :dismissed_keywords, [ :word, :category ], unique: true
  end
end
