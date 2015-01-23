class AddColorToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :color, :string
  end
end
