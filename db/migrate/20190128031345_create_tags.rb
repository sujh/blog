class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :value, null: false, index: true, limit: 20
      t.belongs_to :post, index: true, null: false
      t.timestamps
    end

  end
end
