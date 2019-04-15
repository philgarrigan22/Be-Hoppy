class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :beer, null: false
      t.string :brewery, null: false
      t.integer :rating, null: false
      t.string :location
      t.string :beer_type
      t.string :flavor

      t.timestamps
    end
  end
end
