class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :task
      t.boolean :done

      t.timestamps null: false
    end
  end
end
