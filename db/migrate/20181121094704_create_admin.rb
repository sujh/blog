class CreateAdmin < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name, limit: 20, null: false
      t.string :email, limit: 40, null: true
      t.string :password_salted, null: false
      t.string :salt, null: false
      t.string :occupation, null: true
      t.string :city, null: true
      t.string :skills, null: true
      t.string :introduction, null: true
      t.timestamps
    end
  end
end
