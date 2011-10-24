class CreatePoiCategories < ActiveRecord::Migration
  def change
    create_table :poi_categories do |t|
      t.column :name, :string
      t.column :icon, :string
      t.timestamps
    end
  end
end
