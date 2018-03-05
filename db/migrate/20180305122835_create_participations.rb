class CreateParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :participations do |t|
      t.text :gift_message
      t.string :state
      t.monetize :amount, currency: { present: false }
      t.jsonb :payment
      t.references :gift, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
