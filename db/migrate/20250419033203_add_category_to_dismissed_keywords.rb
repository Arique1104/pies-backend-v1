class AddCategoryToDismissedKeywords < ActiveRecord::Migration[8.0]
  def change
    add_column :dismissed_keywords, :category, :string
  end
end
