class CreateReferrals < ActiveRecord::Migration[5.2]
  def change
    create_table :referrals do |t|
      t.references :partner, foreign_key: true, index: true
      t.string :last_state, default: 'review', null: false
      t.jsonb :original_response, default: {}, null: false

      t.timestamps
    end
  end
end
