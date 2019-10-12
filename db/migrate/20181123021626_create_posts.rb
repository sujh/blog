class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :view_counts, default: 0, null: false
      t.boolean :is_public, null: false, default: true
      t.references :admin, null: false
      t.timestamps
    end
  end
end
