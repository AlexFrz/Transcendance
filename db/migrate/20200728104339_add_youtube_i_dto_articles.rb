class AddYoutubeIDtoArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :youtube_id, :string
  end
end
