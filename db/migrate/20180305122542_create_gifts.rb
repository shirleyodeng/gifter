class CreateGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
