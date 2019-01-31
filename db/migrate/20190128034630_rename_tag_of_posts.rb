class RenameTagOfPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :tag, :tags_str
  end
end
