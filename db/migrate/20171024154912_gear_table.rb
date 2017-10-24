class GearTable < ActiveRecord::Migration
  def change
    create_table :gears do |t|
      t.integer :user_id
      t.string :name
    end
  end
end
