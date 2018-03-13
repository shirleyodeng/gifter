class ChangeUidToString < ActiveRecord::Migration[5.1]
  def change
    change_column(:events, :uid, :string)
  end
end
