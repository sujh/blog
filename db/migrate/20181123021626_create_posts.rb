class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :tag
      t.integer :view_counts, default: 0, null: false

      t.timestamps
    end
  end
end
