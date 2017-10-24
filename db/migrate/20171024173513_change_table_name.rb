class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :gear, :gears
  end
end
