class RenameColumnToFavolites < ActiveRecord::Migration
  def change
    rename_column :favorites, :micropost_id_id, :micropost_id
    rename_column :favorites, :user_id_id, :user_id
  end
end
