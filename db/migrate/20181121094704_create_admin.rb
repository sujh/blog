class CreateAdmin < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name, limit: 20, null: false
      t.string :email, limit: 40, null: true
      t.string :password_salted, null: false
      t.string :salt, null: false
      t.string :job, null: true
      t.string :city, null: true
      t.integer :failed_count, default: 0, null: true
      t.timestamps
    end
  end
end
