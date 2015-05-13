class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :running_time
      t.integer :track
      t.references :album, index: true
      t.references :band, index: true

      t.timestamps
    end
  end
end
