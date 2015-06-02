class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :email
      t.string :username
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :avatar_url
      t.string :phone

      t.timestamps null: false
    end
  end
end
