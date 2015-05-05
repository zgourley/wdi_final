class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :qty
      t.boolean :checked

      t.timestamps null: false
    end
  end
end
