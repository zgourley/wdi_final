class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :body
      t.references :movie, index: true

      t.timestamps null: false
    end
    add_foreign_key :reviews, :movies
  end
end
