class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :child_name
      t.string :child_photo
      t.string :name
      t.date :date
      t.string :account_name
      t.string :sort_code
      t.string :account_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
