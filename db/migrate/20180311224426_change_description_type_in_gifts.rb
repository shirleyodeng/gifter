class ChangeDescriptionTypeInGifts < ActiveRecord::Migration[5.1]
  def change
    change_column :gifts, :description, :text
  end
end
