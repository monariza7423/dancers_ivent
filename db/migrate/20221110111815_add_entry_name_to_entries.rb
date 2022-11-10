class AddEntryNameToEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :entry_name, :string
  end
end
