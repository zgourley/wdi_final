class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :year_released
      t.string :running_time
      t.references :band, index: true
      t.references :genre, index: true

      t.timestamps
    end
  end
end
