class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :password_digest
      t.string :api_key

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
