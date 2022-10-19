class AddYoutubeUrlToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :youtube_url, :string
  end
end
