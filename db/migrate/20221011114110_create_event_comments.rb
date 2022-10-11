class CreateEventComments < ActiveRecord::Migration[6.1]
  def change
    create_table :event_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
