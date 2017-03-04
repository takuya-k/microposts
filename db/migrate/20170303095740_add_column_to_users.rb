class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :string
    add_column :users, :area, :string
    add_column :users, :birthday, :integer
  end
end
