class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :referral, foreign_key: true, index: true
      t.integer :position, null: false
      t.string :state, null: false
      t.text :notes

      t.timestamps
    end
    add_index :reviews, :position
    add_index :reviews, :state
  end
end
