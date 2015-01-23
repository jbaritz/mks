class CreateMartians < ActiveRecord::Migration
  def change
    create_table :martians do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
