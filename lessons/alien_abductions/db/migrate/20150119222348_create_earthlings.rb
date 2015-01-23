class CreateEarthlings < ActiveRecord::Migration
  def change
    create_table :earthlings do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
