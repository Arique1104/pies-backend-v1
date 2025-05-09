class AddExampleToDismissedKeywords < ActiveRecord::Migration[8.0]
  def change
    add_column :dismissed_keywords, :example, :text
  end
end
