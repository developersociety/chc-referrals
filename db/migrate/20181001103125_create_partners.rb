class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.boolean :accepting_referrals, null: false, default: true
      t.string :form_url, null: false
      t.string :name, null: false
      t.integer :max_monthly_referrals, null: false
      t.string :slug, null: false, index: true, unique: true
      t.string :webhook_token, null: false, index: true, unique: true

      t.timestamps
    end
  end
end
