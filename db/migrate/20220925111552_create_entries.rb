class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.integer :competition_id, null: false

      t.timestamps
    end
  end
end
