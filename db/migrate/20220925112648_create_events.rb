class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :competition_id, null: false
      t.string :address, null: false
      t.string :venue, null: false
      t.datetime :day, null: false

      t.timestamps
    end
  end
end
