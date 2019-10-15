class CreatePostDrafts < ActiveRecord::Migration[5.2]
  def change
    create_table :post_drafts do |t|
      t.string :title
      t.text :content
      t.references :post
      t.references :admin, null: false, index: true

      t.timestamps
    end
  end
end
