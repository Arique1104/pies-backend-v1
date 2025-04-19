class ChangeEventIdToBeNullableInPiesEntries < ActiveRecord::Migration[8.0]
  def change
    change_column_null :pies_entries, :event_id, true
  end
end
