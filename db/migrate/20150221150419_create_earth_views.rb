class CreateEarthViews < ActiveRecord::Migration
  def change
    create_table :earth_views do |t|
      t.integer :prettyearth_id, null: false
      t.references :country, index: true
      t.decimal :lat
      t.decimal :lng
      t.integer :zoom

      t.timestamps null: false
    end
    add_foreign_key :earth_views, :countries
    add_index :earth_views, :prettyearth_id, unique: true
  end
end
