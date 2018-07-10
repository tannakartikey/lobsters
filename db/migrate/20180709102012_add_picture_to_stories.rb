class AddPictureToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :picture, :string
  end
end
