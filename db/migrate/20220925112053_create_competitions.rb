class CreateCompetitions < ActiveRecord::Migration[6.1]
  def change
    create_table :competitions do |t|
      t.integer :genre_id, null: false
      t.text :overview, null: false
      t.text :rule, null: false
      t.string :judge, null: false
      t.string :dj, null: false
      t.string :mc, null: false
      t.integer :prize, null: false

      t.timestamps
    end
  end
end
