class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|

      t.timestamps
      t.string :title
      t.string :soundcloud_url
    end
  end
end
