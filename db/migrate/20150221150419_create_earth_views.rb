class CreateEarthViews < ActiveRecord::Migration
  def change
    create_table :earth_views do |t|
      t.integer :json_id, unique: true, null: false, index: true
      t.references :country, index: true
      t.decimal :lat
      t.decimal :lng

      t.timestamps null: false
    end
    add_foreign_key :earth_views, :countries
  end
end
