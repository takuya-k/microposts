class AddOriginNameToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :origin_name, :string
  end
end
