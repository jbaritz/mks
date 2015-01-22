class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :video_id, references: :videos
      t.string :content
      t.timestamps
    end
  end
end
