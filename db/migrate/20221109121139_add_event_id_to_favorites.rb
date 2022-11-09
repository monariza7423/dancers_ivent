class AddEventIdToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :event_id, :integer
  end
end
