class CreatePostDrafts < ActiveRecord::Migration[5.2]
  def change
    create_table :post_drafts do |t|
      t.string :title
      t.text :content
      t.references :post, null: false
      t.references :admin, null: false

      t.timestamps
    end
  end
end
