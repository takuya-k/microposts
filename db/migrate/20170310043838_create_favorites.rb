class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :micropost, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
