class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :ingredients
      t.text :directions
      t.string :cooktime
      t.string :preptime
      t.integer :oventemp
      t.string :tempunits
      t.string :measurementunits
      t.string :genre
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
