class CreatePostTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :value, null: false
      t.integer :posts_count, default: 0, null: false
      t.index :value, unique: true
      t.timestamps
    end

    create_table :post_tags do |t|
      t.belongs_to :tag, index: true, null: false
      t.belongs_to :post, index: true, null: false
    end

  end
end
