class CreateAbductions < ActiveRecord::Migration
  def change
    create_table :abductions do |t|
      t.references :martian, index: true
      t.references :earthling, index: true

      t.timestamps null: false
    end
    add_foreign_key :abductions, :martians
    add_foreign_key :abductions, :earthlings
  end
end
